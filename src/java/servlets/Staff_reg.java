/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import resources.Customer;
import resources.JobRoll;
import resources.Staff;

/**
 *
 * @author Chamara
 */
@WebServlet(name = "Staff_reg", urlPatterns = {"/Staff_reg"})
public class Staff_reg extends HttpServlet {

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
        try {

            Session ses = connection.GetConnection.getSessionFactory().openSession();

            String name = request.getParameter("n");
            String mobile = request.getParameter("m");
            String address = request.getParameter("a");            
            
            int jobrole = Integer.parseInt(request.getParameter("j"));   

            String nic = request.getParameter("ni");
            Object stf =  ses.createCriteria(Staff.class).add(Restrictions.eq("nic", nic)).uniqueResult();

            if (stf == null) {

                Staff sa = new Staff();

                sa.setName(name);
                sa.setMobile(mobile);
                sa.setAddress(address);
                sa.setNic(nic);

                sa.setJobRoll((JobRoll) ses.load(JobRoll.class, jobrole));

                Transaction tr = ses.beginTransaction();
                ses.save(sa);
                tr.commit();
                ses.flush();
                ses.close();
                response.sendRedirect("staff_reg.jsp");

            } else {
                 response.sendRedirect("staff_reg.jsp?msg=Same Nic Used For Another Staff Member ");
                
            }

        } catch (Exception e) {
            e.printStackTrace();
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
