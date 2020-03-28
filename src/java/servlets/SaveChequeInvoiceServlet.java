/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import connection.GetConnection;
import help.Helper;
import holder.InvoiceItemHolder;
import holder.LogedUserHolder;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.Transaction;
import resources.Customer;
import resources.Invoice;
import resources.InvoiceChequeDetails;
import resources.InvoiceItem;
import resources.InvoicePayment;
import resources.PaymentType;
import resources.Stock;
import resources.User;

/**
 *
 * @author SCORFi3LD
 */
@WebServlet(name = "SaveChequeInvoiceServlet", urlPatterns = {"/SaveChequeInvoiceServlet"})
public class SaveChequeInvoiceServlet extends HttpServlet {

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
            
            int cus = Integer.parseInt(request.getParameter("cus"));
            double sub = Double.parseDouble(request.getParameter("sub"));
            double dis = Double.parseDouble(request.getParameter("dis"));
            double net = Double.parseDouble(request.getParameter("net"));

            String chqtype = request.getParameter("chqtype");
            String chqno = request.getParameter("chqno");
            String chqdate = request.getParameter("chqdate");
            String bank = request.getParameter("bank");
            String branch = request.getParameter("branch");
            double amount = Double.parseDouble(request.getParameter("amount"));
            String chqimg = request.getParameter("chqimg");

            double bal = amount - net;

            LogedUserHolder userHolder = (LogedUserHolder) request.getSession().getAttribute("admin");
            int userid = userHolder.getUserId();

            Session s = GetConnection.getSessionFactory().openSession();
            Transaction tr = s.beginTransaction();

            Customer c = (Customer) s.load(Customer.class, cus);
            User u = (User) s.load(User.class, userid);

            // invoice_id   total  discount  net_total    cash  balance     due  date      time    status  customer_id  user_id 
            Invoice i = new Invoice();
            i.setCustomer(c);
            i.setUser(u);
            i.setTotal(sub);
            i.setDiscount(dis);
            i.setNetTotal(net);
            i.setCash(amount);
            if (bal >= 0) {         // + balance
                i.setBalance(bal);
                i.setDue(0d);
            } else {                // - due
                i.setBalance(0d);
                i.setDue(net - amount);
            }
            i.setDate(Helper.getDate());
            i.setTime(Helper.getTime());
            i.setStatus(1);
            s.save(i);

            if (amount != 0d) {
                PaymentType pt = (PaymentType) s.load(PaymentType.class, 2); // CHEQUE

                // invoice_payment_id  invoice_id  payment_type_id  date    time    amount  status
                InvoicePayment ip = new InvoicePayment();
                ip.setInvoice(i);
                ip.setPaymentType(pt);
                ip.setDate(Helper.getDate());
                ip.setTime(Helper.getTime());
                ip.setAmount(amount);
                ip.setStatus(1);
                s.save(ip);
                
                //invoice_cheque_details_id  invoice_payment_id  type    cheque_no  cheque_date  bank    branch  amount  cheque_image  status 
                InvoiceChequeDetails chq = new InvoiceChequeDetails();
                chq.setInvoicePayment(ip);
                chq.setType(chqtype);
                chq.setChequeNo(chqno);
                chq.setChequeDate(chqdate);
                chq.setBank(bank);
                chq.setBranch(branch);
                chq.setAmount(amount);
                chq.setChequeImage(chqimg);
                chq.setStatus(1);
                s.save(chq);                
            }

            for (InvoiceItem item : holder.getHolder()) {
                item.setInvoice(i);
                s.save(item);

                int stId = item.getStock().getStockId();
                Stock st = (Stock) s.load(Stock.class, stId);
                st.setQty(st.getQty() - item.getQty());
                s.update(st);
            }

            tr.commit();
            s.close();

            holder.clear();

            out.write(String.valueOf(i.getInvoiceId()));
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
