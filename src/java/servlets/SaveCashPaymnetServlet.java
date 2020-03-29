/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import connection.GetConnection;
import help.Helper;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.Transaction;
import resources.Invoice;
import resources.InvoicePayment;
import resources.PaymentType;

/**
 *
 * @author SCORFi3LD
 */
@WebServlet(name = "SaveCashPaymnetServlet", urlPatterns = {"/SaveCashPaymnetServlet"})
public class SaveCashPaymnetServlet extends HttpServlet {

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

            int id = Integer.parseInt(request.getParameter("id"));
            double amount = Double.parseDouble(request.getParameter("amount"));

            Session s = GetConnection.getSessionFactory().openSession();
            Transaction tr = s.beginTransaction();

            Invoice i = (Invoice) s.load(Invoice.class, id);
            PaymentType pt = (PaymentType) s.load(PaymentType.class, 1); // CASH

            if (i.getDue() < amount) {
                out.print("0");
                return;
            }

            // invoice_payment_id  invoice_id  payment_type_id  date    time    amount  status
            InvoicePayment ip = new InvoicePayment();
            ip.setInvoice(i);
            ip.setPaymentType(pt);
            ip.setDate(Helper.getDate());
            ip.setTime(Helper.getTime());
            ip.setAmount(amount);
            ip.setStatus(1);
            s.save(ip);

            i.setDue(i.getDue() - amount);
            s.update(i);

            tr.commit();
            s.close();
            out.print("1");
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
