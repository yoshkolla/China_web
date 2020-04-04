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
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author AKILA
 */
@WebServlet(name = "RemoveItemFromGRNServlet", urlPatterns = {"/RemoveItemFromGRNServlet"})
public class RemoveItemFromGRNServlet extends HttpServlet {

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

            // Get param Data
            int param_rawItemID = Integer.valueOf(request.getParameter("rmvItem_RawItemID"));
            double param_unitPrice = Double.valueOf(request.getParameter("rmvItem_UnitPrice"));
            double param_supplierPrice = Double.valueOf(request.getParameter("rmvItem_SupplierPrice"));
            double param_discount = Double.valueOf(request.getParameter("rmvItem_Discount"));

            // Check & Select Removing-Item [ RawItemID  &  UnitPrice  & SupplierPrice  &  Discount ] --------------------------------------------------------------------
            GRN_ITEM_OBJ removing_GRNItemObj = null;
            for (GRN_ITEM_OBJ rawItemsList : dtHolder.getHolder()) {
                if (rawItemsList.getRawItem().getRawItemsId() == param_rawItemID) {
                    if (rawItemsList.getUnitPrice() == param_unitPrice) {
                        if (rawItemsList.getSupplierPrice() == param_supplierPrice) {
                            if (rawItemsList.getDiscount() == param_discount) {
                                removing_GRNItemObj = rawItemsList;
                                break;
                            }
                        }
                    }
                }
            }

            // Remove Item from Data-Holder... -----------------------------------------------------------------------------------
            if (removing_GRNItemObj != null) {
                dtHolder.getHolder().remove(removing_GRNItemObj);
            }
            request.getSession().setAttribute("GrnItems", dtHolder);

            out.print("success::Done!");
        } catch (Exception e) {
            e.printStackTrace();
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
