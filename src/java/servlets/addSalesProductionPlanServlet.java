/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import holder.ProductionPlanHolder;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "addSalesProductionPlanServlet", urlPatterns = {"/addSalesProductionPlanServlet"})
public class addSalesProductionPlanServlet extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        try{
            if(request.getParameter("name") == null || request.getParameter("name").equals("")
                    || request.getParameter("cost") == null || request.getParameter("cost").equals("")){
                    out.print("0");
            }else{
                String NAME = request.getParameter("name");
                double COST = Double.parseDouble(request.getParameter("cost"));
                ArrayList<ProductionPlanHolder> pph = new ArrayList();
                if(request.getSession().getAttribute("ppl") != null){
                    pph = (ArrayList<ProductionPlanHolder>) request.getSession().getAttribute("ppl");
                }
                ProductionPlanHolder ph = new ProductionPlanHolder();
                ph.setId(0);
                ph.setCost(COST);
                ph.setName(NAME);
                pph.add(ph);
                out.print("1");
                
            }
        }catch(Exception e){
        
        }
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

   

}
