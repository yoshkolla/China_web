/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import connection.GetConnection;
import holder.GRNItems_DataHolder;
import holder.GRN_ITEM_OBJ;
import holder.LogedUserHolder;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import resources.Grn;
import resources.GrnItem;
import resources.RawStock;
import resources.Supplier;
import resources.User;

/**
 *
 * @author AKILA
 */
@WebServlet(name = "SaveGRNServlet", urlPatterns = {"/SaveGRNServlet"})
public class SaveGRNServlet extends HttpServlet {

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
                          [ 02 ] Save GRN-Details
                          [ 03 ] Save/ Update Raw-Stock-Items ( for{} )
                          [ 04 ] Save GRN-Items ( for{} )
                          [ 05 ] Clear Data-Holder
                          [ 06 ] Finalize...
             */
            // [ 01 ]  Main Param OBJECTS =======================================================================================
            DecimalFormat dfPrice = new DecimalFormat("0.00");
            DecimalFormat dfQty = new DecimalFormat("0.000");
            String sdfDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
            String sdfTime = new SimpleDateFormat("hh:mm:ss a").format(new Date());

            GRNItems_DataHolder dtHolder = (GRNItems_DataHolder) request.getSession().getAttribute("GrnItems");
            Session sess = GetConnection.getSessionFactory().openSession();
            Transaction trans = sess.beginTransaction();

            LogedUserHolder userHolder = (LogedUserHolder) request.getSession().getAttribute("admin");
            User param_userObj = (User) sess.load(User.class, userHolder.getUserId());
            Supplier param_supplierObj = (Supplier) sess.load(Supplier.class, Integer.valueOf(request.getParameter("grn_supplier")));
            double param_totalAmount = Double.valueOf(request.getParameter("grn_totalAmount"));
            double param_totalDiscountAmount = Double.valueOf(request.getParameter("grn_totalDisc"));
            double param_netTotal = Double.valueOf(request.getParameter("grn_netTotal"));

            // [ 02 ]  SAVE GRN DETAILS =======================================================================================
            Grn grnDetails = new Grn();
            grnDetails.setSupplier(param_supplierObj);
            grnDetails.setTotal(param_totalAmount);
            grnDetails.setCash(0.00);
            grnDetails.setBalance(param_netTotal);
            grnDetails.setDate(sdfDate);
            grnDetails.setTime(sdfTime);
            grnDetails.setDiscount(param_totalDiscountAmount);
            grnDetails.setNetTotal(param_netTotal);
            grnDetails.setStatus(1);
            grnDetails.setUser(param_userObj);
            sess.save(grnDetails);

            for (GRN_ITEM_OBJ grnItemsLIST : dtHolder.getHolder()) {

                // [ 03 ]  SAVE/ UPDATE RAW-STOCK-ITEMS  =============================================================================
                // >>>>
                // check same-batch existings... [ Raw-items-id & Cost  ]
                Criteria crt_RawStock = sess.createCriteria(RawStock.class);
                crt_RawStock.add(Restrictions.and(Restrictions.eq("rawItems", grnItemsLIST.getRawItem()), Restrictions.eq("cost", grnItemsLIST.getSupplierPrice())));
                RawStock rawStock_Batch = null;
                if (crt_RawStock.uniqueResult() != null) { // SAME BATCH EXIST >> UPDATE Qty, date, time
                    rawStock_Batch = (RawStock) crt_RawStock.uniqueResult();
                    rawStock_Batch.setQty(rawStock_Batch.getQty() + grnItemsLIST.getQty());
                    rawStock_Batch.setDate(sdfDate);
                    rawStock_Batch.setTime(sdfTime);
                    sess.update(rawStock_Batch);

                } else { // BATCH NOT FOUND >> ADD as New BATCH
                    rawStock_Batch = new RawStock();
                    rawStock_Batch.setRawItems(grnItemsLIST.getRawItem());
                    rawStock_Batch.setCost(grnItemsLIST.getSupplierPrice());
                    rawStock_Batch.setQty(grnItemsLIST.getQty());
                    rawStock_Batch.setDate(sdfDate);
                    rawStock_Batch.setTime(sdfTime);
                    sess.save(rawStock_Batch);
                }

                // [ 04 ]  SAVE GRN-ITEMS =========================================================================================
                GrnItem grnItem = new GrnItem();
                grnItem.setGrn(grnDetails);
                grnItem.setRawStock(rawStock_Batch);
                grnItem.setUnitPrice(grnItemsLIST.getUnitPrice());
                grnItem.setCost(grnItemsLIST.getSupplierPrice());
                grnItem.setQty(grnItemsLIST.getQty());
                grnItem.setTotal(grnItemsLIST.getAmount());
                grnItem.setDiscount(grnItemsLIST.getDiscount());
                grnItem.setNetTotal(grnItemsLIST.getTotalAmount());
                grnItem.setStatus(1);
                sess.save(grnItem);
            }

            // [ 05 ]  CLEAR DATA_HOLDER =======================================================================================
            dtHolder.clear();

            // [ 06 ] Finalize ==========================================================================================================
            trans.commit();
            sess.close();
            out.print("success::GRN Save Successful!");

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
