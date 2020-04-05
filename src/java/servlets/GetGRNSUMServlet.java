/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import holder.GRNItems_DataHolder;
import holder.GRN_ITEM_OBJ;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author AKILA
 */
@WebServlet(name = "GetGRNSUMServlet", urlPatterns = {"/GetGRNSUMServlet"})
public class GetGRNSUMServlet extends HttpServlet {

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

            GRNItems_DataHolder dtHolder = (GRNItems_DataHolder) request.getSession().getAttribute("GrnItems");

            // SUM ---> Total_Amount | Total_Discount | Net_Total
            double totalAmount = 0.00;
            double totalDscnt = 0.00;
            double netTotal = 0.00;
            for (GRN_ITEM_OBJ item : dtHolder.getHolder()) {
                totalAmount = totalAmount + item.getAmount();
                totalDscnt = totalDscnt + item.getDiscount_amount();
                netTotal = netTotal + item.getTotalAmount();
            }

            // GRN save opt. status
            boolean flag_NetTot = false;
            if (netTotal != 0.00) {
                flag_NetTot = true;
            }

            out.print("success:" + new DecimalFormat("0.00").format(totalAmount) + ":" + new DecimalFormat("0.00").format(totalDscnt) + ":" + new DecimalFormat("0.00").format(netTotal) + ":" + flag_NetTot);

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