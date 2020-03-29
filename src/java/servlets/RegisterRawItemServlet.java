/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import resources.MeasurementType;
import resources.RawItems;

/**
 *
 * @author AKILA
 */
@WebServlet(name = "RegisterRawItemServlet", urlPatterns = {"/RegisterRawItemServlet"})
public class RegisterRawItemServlet extends HttpServlet {

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
            //Get details through param
            String itemName = request.getParameter("regRawItem_name");
            int msrType = Integer.valueOf(request.getParameter("regRawItem_msrType"));
            double rol = Double.valueOf(request.getParameter("regRawItem_rol"));

            Session sess = connection.GetConnection.getSessionFactory().openSession();
            Transaction tr = sess.beginTransaction();

            // Check Name Exist Status...
            Criteria itemNameExistCriteria = sess.createCriteria(RawItems.class);
            itemNameExistCriteria.add(Restrictions.eq("name", itemName));
            RawItems itemNameObject = (RawItems) itemNameExistCriteria.uniqueResult();
            if (itemNameObject == null) {

                // Register New-Raw-Item 
                RawItems newRawItem = new RawItems();
                newRawItem.setName(itemName);
                newRawItem.setRol(rol);
                newRawItem.setStatus(1);

                MeasurementType measurementType = (MeasurementType) sess.load(MeasurementType.class, msrType);
                newRawItem.setMeasurementType(measurementType);

                sess.save(newRawItem);
                tr.commit();
                sess.close();
                out.print("Success:Registration Succesfully..!");

            } else { // when Name already exist
                out.print("Warning:Sorry, This Name has been already exist..!");
            }
        } catch (Exception e) {
            out.print("Warning:Sorry, Operation Faild!");
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
