/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import connection.GetConnection;
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
import org.hibernate.Session;
import resources.RawItems;

/**
 *
 * @author AKILA
 */
@WebServlet(name = "AddItemToGRNServlet", urlPatterns = {"/AddItemToGRNServlet"})
public class AddItemToGRNServlet extends HttpServlet {

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
            DecimalFormat dfPrice = new DecimalFormat("0.00");
            Session sess = GetConnection.getSessionFactory().openSession();
            GRNItems_DataHolder dtHolder = (GRNItems_DataHolder) request.getSession().getAttribute("GrnItems");

            // Get param Data
            RawItems param_rawItemObject = (RawItems) sess.load(RawItems.class, Integer.valueOf(request.getParameter("addItem_ItemID")));
            double param_unitPrice = Double.valueOf(request.getParameter("addItem_unitPrice"));
            double param_supplierPrice = Double.valueOf(request.getParameter("addItem_supplierPrice"));
            double param_qty = Double.valueOf(request.getParameter("addItem_qty"));
            double param_discount = Double.valueOf(request.getParameter("addItem_discount"));

            // Check Duplicate Existings [ RawItemID  &  UnitPrice  & SupplierPrice  &  Discount ] --------------------------------------------------------------------
            GRN_ITEM_OBJ existing_GRNItemObj = null;
            for (GRN_ITEM_OBJ rawItemsList : dtHolder.getHolder()) {
                if (rawItemsList.getRawItem().getRawItemsId() == param_rawItemObject.getRawItemsId()) {
                    if (rawItemsList.getUnitPrice() == param_unitPrice) {
                        if (rawItemsList.getSupplierPrice() == param_supplierPrice) {
                            if (rawItemsList.getDiscount() == param_discount) {
                                existing_GRNItemObj = rawItemsList;
                                break;
                            }
                        }
                    }
                }
            }

            // update values --> when Duplicate ITEM FOUND !!     [ Qty, DiscountAmount, Amount, TotalAmount ] ----------------------------------------------------------
            if (existing_GRNItemObj != null) {
                existing_GRNItemObj.setQty(existing_GRNItemObj.getQty() + param_qty);

                double val_Amount = (existing_GRNItemObj.getUnitPrice() * existing_GRNItemObj.getQty()) + (param_supplierPrice * param_qty);
                existing_GRNItemObj.setDiscount_amount(existing_GRNItemObj.getDiscount_amount() + ((val_Amount * param_discount) / 100));
                existing_GRNItemObj.setAmount(Double.valueOf(dfPrice.format(val_Amount)));
                existing_GRNItemObj.setTotalAmount(Double.valueOf(dfPrice.format(val_Amount - ((val_Amount * param_discount) / 100))));

            } else { // add as NEW GRN-ITEM !! -----------------------------------------------------------------------------------
                GRN_ITEM_OBJ newRawItem = new GRN_ITEM_OBJ();
                newRawItem.setRawItem(param_rawItemObject);
                newRawItem.setUnitPrice(param_unitPrice);
                newRawItem.setSupplierPrice(param_supplierPrice);
                newRawItem.setQty(param_qty);
                newRawItem.setDiscount(param_discount);

                double val_Amount = param_supplierPrice * param_qty;
                newRawItem.setDiscount_amount((val_Amount * param_discount) / 100);
                newRawItem.setAmount(Double.valueOf(dfPrice.format(val_Amount)));
                newRawItem.setTotalAmount(Double.valueOf(dfPrice.format(val_Amount - ((val_Amount * param_discount) / 100))));

                dtHolder.getHolder().add(newRawItem);
            }

            request.getSession().setAttribute("GrnItems", dtHolder);

            out.print("success::Done!");

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
