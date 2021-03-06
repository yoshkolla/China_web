/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import holder.DetailsHolder;
import holder.LogedUserHolder;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import resources.Details;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "GetLoginServlet", urlPatterns = {"/GetLoginServlet"})
public class GetLoginServlet extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        if (request.getParameter("email").equals("") || request.getParameter("password").equals("")) {

            out.print(0);

        } else {
            
            Session ses = connection.GetConnection.getSessionFactory().openSession();
            Criteria cr = ses.createCriteria(User.class);
            cr.add(Restrictions.eq("username", request.getParameter("email")));
            cr.add(Restrictions.eq("password", request.getParameter("password")));
            cr.add(Restrictions.eq("status", 1));
            List<User> AD = cr.list();
            System.out.println("");
            if (AD.size() == 1) {
                HttpSession session = request.getSession(true);
                for(User A : AD) {
                    LogedUserHolder lg = new LogedUserHolder(A.getUserId(), A.getStaff().getStaffId(), A.getStaff().getName() , A.getUsername() ,A.getSales() , A.getPurchase() , A.getProduction() ,A.getCreates() , A.getUser() , A.getCheque() ,A.getReport() , A.getOther());
                    Details dt = (Details) ses.load(Details.class, 1);
                    
                    DetailsHolder dh = new DetailsHolder();
                    dh.setAddress(dt.getAddress());
                    dh.setDomain(dt.getDomain());
                    dh.setEmail(dt.getEmail());
                    dh.setFax(dt.getFax());
                    dh.setImage(dt.getImage());
                    dh.setName(dt.getName());
                    dh.setTp(dt.getTp());
                    
                    
                    session.setAttribute("admin", lg);
                    session.setAttribute("details", dh);
                    
                }

                out.print("1");

            } else {
                out.print("2");

            }
            ses.close();
        }
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    
}
