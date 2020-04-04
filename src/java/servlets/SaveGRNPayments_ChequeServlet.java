/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import connection.GetConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.Transaction;
import resources.Grn;
import resources.GrnChequeDetails;
import resources.GrnPayment;
import resources.PaymentType;

/**
 *
 * @author AKILA
 */
@WebServlet(name = "SaveGRNPayments_ChequeServlet", urlPatterns = {"/SaveGRNPayments_ChequeServlet"})
public class SaveGRNPayments_ChequeServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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

            /* 
                           ------------------- PROCESS ORDER --------------------------
                          [ 01 ] Declare Main Param Objects
                          [ 02 ] Save GRN_Payment
                          [ 03 ] Save GRN_Cheque_Details
                          [ 04 ] Update GRN's values --> cash & balance
                          [ 05 ] Finalize...
             */
            // [ 01 ]  Main Param OBJECTS =======================================================================================
            Session sess = GetConnection.getSessionFactory().openSession();
            Transaction tr = sess.beginTransaction();
            String sdfDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
            String sdfTime = new SimpleDateFormat("hh:mm:ss a").format(new Date());

            Grn param_GrnObjc = (Grn) sess.load(Grn.class, Integer.parseInt(request.getParameter("grnid")));
            PaymentType pymntType = (PaymentType) sess.load(PaymentType.class, 2); // CHEQUE
            String param_chqtype = request.getParameter("chqtype");
            String param_chqno = request.getParameter("chqno");
            String param_chqdate = request.getParameter("chqdate");
            String param_bank = request.getParameter("bank");
            String param_branch = request.getParameter("branch");
            double param_PaymentAmount = Double.parseDouble(request.getParameter("chqpay"));
            String param_chqimg = request.getParameter("chqimg");
            if (param_chqimg.isEmpty()) {
                param_chqimg = "assets/img/image_placeholder.jpg";
            }

            // [ 02 ]  SAVE GRN_PAYMENT =======================================================================================
            GrnPayment grnPmnt = new GrnPayment();
            grnPmnt.setGrn(param_GrnObjc);
            grnPmnt.setPaymentType(pymntType);
            grnPmnt.setDate(sdfDate);
            grnPmnt.setTime(sdfTime);
            grnPmnt.setAmount(param_PaymentAmount);
            grnPmnt.setStatus(1);
            sess.save(grnPmnt);

            // [ 03 ]  SAVE GRN_CHEQUE_DETAILS ==================================================================================
            GrnChequeDetails grnChqDtls = new GrnChequeDetails();
            grnChqDtls.setGrnPayment(grnPmnt);
            grnChqDtls.setType(param_chqtype);
            grnChqDtls.setChequeNo(param_chqno);
            grnChqDtls.setChequeDate(param_chqdate);
            grnChqDtls.setBank(param_bank);
            grnChqDtls.setBranch(param_branch);
            grnChqDtls.setAmount(param_PaymentAmount);
            grnChqDtls.setChequeImage(param_chqimg);    //  /!\  /!\ /!\ [      Need 2 fix Image-Base64 save Issue     ] /!\ /!\ /!\
            grnChqDtls.setStatus(1);
            sess.save(grnChqDtls);

            // [ 04 ]  UPDATE GRN's VALUES [ cash & balance ] =========================================================================
            param_GrnObjc.setCash(param_GrnObjc.getCash() + param_PaymentAmount);
            param_GrnObjc.setBalance(param_GrnObjc.getBalance() - param_PaymentAmount);
            sess.update(param_GrnObjc);

            // [ 05 ] Finalize ================================================================================================
            tr.commit();
            sess.close();
            out.print("success::Cheque-Payment Save Successful!");

        } catch (Exception e) {
            out.print("error:Sorry:Operation Faild!");
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
