/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import holder.ProductionPlanHolder;
import holder.ProductionRawMatHolder;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import resources.RawItems;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "addRowMatItemsServlet", urlPatterns = {"/addRowMatItemsServlet"})
public class addRowMatItemsServlet extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        try {
            if (request.getParameter("rol") == null || request.getParameter("rol").equals("")
                    || request.getParameter("amount") == null || request.getParameter("amount").equals("")) {
                out.print("0");
            } else {
                int RO_ID = Integer.parseInt(request.getParameter("rol"));
                Session ses = connection.GetConnection.getSessionFactory().openSession();

                RawItems RI = (RawItems) ses.load(RawItems.class, RO_ID);
                String NAME = RI.getName();
                double AMOUNT = Double.parseDouble(request.getParameter("amount"));

                ArrayList<ProductionRawMatHolder> pph = new ArrayList();
                if (request.getSession().getAttribute("rrl") != null) {
                    pph = (ArrayList<ProductionRawMatHolder>) request.getSession().getAttribute("rrl");
                }
                boolean flag = true;
                for (ProductionRawMatHolder p : pph) {
                    if (p.getRow_id() == RO_ID) {
                        double curr = p.getAmount();
                        p.setAmount(AMOUNT + curr);
                        flag = false;
                    }
                }
                if (flag){
                    ProductionRawMatHolder ph = new ProductionRawMatHolder();
                    ph.setId(0);
                    ph.setAmount(AMOUNT);
                    ph.setName(NAME);
                    ph.setRow_id(RO_ID);
                    pph.add(ph);
                }

                request.getSession().setAttribute("rrl", pph);
                out.print("1");

            }
        } catch (Exception e) {

        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
