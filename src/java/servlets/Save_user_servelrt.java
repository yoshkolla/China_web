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
import org.hibernate.Session;
import org.hibernate.Transaction;
import resources.Customer;
import resources.JobRoll;
import resources.Staff;
import resources.User;

/**
 *
 * @author Chamara
 */
@WebServlet(name = "Save_user_servelrt", urlPatterns = {"/Save_user_servelrt"})
public class Save_user_servelrt extends HttpServlet {

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
            User u = new User();

            u.setUsername(request.getParameter("Username"));
            u.setPassword(request.getParameter("Password"));
            u.setSales(request.getParameter("Sales"));
            u.setPurchase(request.getParameter("Purchase"));
            u.setProduction(request.getParameter("Production"));
            u.setCreates(request.getParameter("Create"));
            u.setUser(request.getParameter("User"));
            u.setCheque(request.getParameter("Cheque"));
            u.setReport(request.getParameter("Report"));
            u.setOther(request.getParameter("Other"));
            int staff = Integer.parseInt(request.getParameter("staff"));
            u.setStaff((Staff) ses.load(Staff.class, staff));
            u.setStatus(Integer.parseInt("1"));

            Transaction tr = ses.beginTransaction();
            ses.save(u);
            tr.commit();
            ses.flush();
            ses.close();

            System.out.println("Done Save User");

            response.sendRedirect("user_reg.jsp");

        } catch (Exception e) {
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
