/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import connection.GetConnection;
import help.Helper;
import holder.InvoiceItemHolder;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import resources.InvoiceItem;
import resources.Stock;

/**
 *
 * @author SCORFi3LD
 */
@WebServlet(name = "AddItemToCartServlet", urlPatterns = {"/AddItemToCartServlet"})
public class AddItemToCartServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            InvoiceItemHolder holder = (InvoiceItemHolder) request.getSession().getAttribute("cart");
            holder.printAll();

            int stockid = Integer.parseInt(request.getParameter("id"));
            double dis = Double.parseDouble(request.getParameter("dis"));
            double qty = Double.parseDouble(request.getParameter("qty") == null ? "1" : request.getParameter("qty"));

            Session s = GetConnection.getSessionFactory().openSession();
            Stock st = (Stock) s.load(Stock.class, stockid);

            InvoiceItem it = null;
            for (InvoiceItem item : holder.getHolder()) {
                if (item.getStock().getStockId() == stockid) {
                    it = item;
                    break;
                }
            }

            if (it != null) {
                it.setQty(it.getQty() + qty);
                it.setTotal(it.getQty() * it.getUnitPrice());
                it.setNetTotal(it.getTotal() - ((it.getTotal() * it.getDiscount()) / 100));
            } else {
                // invoice_item_id  invoice_id  stock_id    cost  unit_price     qty   total  discount  net_total  status
                InvoiceItem item = new InvoiceItem();
                item.setStock(st);
                item.setCost(st.getCost());
                item.setUnitPrice(st.getPrice());
                item.setQty(qty);
                item.setTotal(qty * st.getPrice());
                item.setDiscount(dis);
                item.setNetTotal(item.getTotal() - ((item.getTotal() * item.getDiscount()) / 100));
                item.setStatus(1);

                it = item;
                holder.getHolder().add(item);
            }
            
            request.getSession().setAttribute("cart", holder);
            out.write(Helper.intFormat.format(holder.getHolder().size()) + "," + it.getStock().getItems().getItemsId());
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
