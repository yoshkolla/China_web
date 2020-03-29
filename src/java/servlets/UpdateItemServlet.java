/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import help.Helper;
import holder.ProductionPlanHolder;
import holder.ProductionRawMatHolder;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import org.hibernate.Session;
import org.hibernate.Transaction;
import resources.ItemStaffCost;
import resources.Items;
import resources.ItemsHasRawItems;
import resources.MeasurementType;
import resources.ProductionSteps;
import resources.RawItems;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "UpdateItemServlet", urlPatterns = {"/UpdateItemServlet"})
public class UpdateItemServlet extends HttpServlet {

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
        try {
            if (false) {

            } else {
                String IMG;
                String ID = "";
                String NAME = "";
                String ROL = "";
                String TYPE = "";

                String contextpath = request.getServletContext().getRealPath("");
                String folderpath = contextpath + "/itemimage";
                File folder = new File(folderpath);

                if (!folder.exists()) {
                    folder.mkdir();
                }

                boolean isMultipart = ServletFileUpload.isMultipartContent(request);
                if (!isMultipart) {
                    out.print("0");
                    System.out.println("A");
                } else {

                    //to do this multipart request
                    FileItemFactory factory = new DiskFileItemFactory();
                    ServletFileUpload upload = new ServletFileUpload(factory);
                    List list = upload.parseRequest(request);
                    Iterator itList = list.iterator();

                    while (itList.hasNext()) {
                        FileItem item = (FileItem) itList.next();
                        if (item.isFormField()) {
                            switch (item.getFieldName()) {
                                case "name":
                                    NAME = item.getString();
                                    break;
                                case "id":
                                    ID = item.getString();
                                    break;
                                case "rol":
                                    ROL = item.getString();

                                    break;
                                case "type":
                                    TYPE = item.getString();
                                    break;
                                default:
                                    break;
                            }
                        } else {

                            if (!NAME.equals("") && !ROL.equals("") && !TYPE.equals("") && !ID.equals("")) {
                                Session ses = connection.GetConnection.getSessionFactory().openSession();
                                Transaction tr = ses.beginTransaction();
                                Helper help = new Helper();
                                MeasurementType MT = (MeasurementType) ses.load(MeasurementType.class, Integer.parseInt(TYPE));

                                Items ITEM = (Items) ses.load(Items.class, Integer.parseInt(ID));
                                ITEM.setName(NAME);
                                ITEM.setRol(Double.parseDouble(ROL));
                                ITEM.setStatus("1");
                                ITEM.setMeasurementType(MT);
                                ses.update(ITEM);
                                
                                String itemname = item.getName();
                                String EXT = FilenameUtils.getExtension(itemname);
                                IMG = ITEM.getItemsId() + "." + EXT;
                                if (!itemname.equals("")) {
                                    itemname = IMG;

                                    if (!itemname.equals("") && !itemname.equals("N/A")) {
                                        File uploadedFile = new File(folderpath + "/" + itemname);

                                        item.write(uploadedFile);
                                        Items IT = (Items) ses.load(Items.class, ITEM.getItemsId());
                                        IT.setImage("itemimage/" + IMG);
                                        ses.update(IT);
                                    }

                                }

                                Set<ItemsHasRawItems> RII = ITEM.getItemsHasRawItemses();
                                for (ItemsHasRawItems I : RII) {
                                    I.setStatus(0);
                                    ses.update(I);
                                }

                                Set<ProductionSteps> HI = ITEM.getProductionStepses();
                                for (ProductionSteps I : HI) {
                                    I.setStatus(0);
                                    ses.update(I);
                                }

                                ArrayList<ProductionPlanHolder> pp = new ArrayList();
                                if (request.getSession().getAttribute("ppl") != null) {
                                    pp = (ArrayList<ProductionPlanHolder>) request.getSession().getAttribute("ppl");
                                    request.getSession().removeAttribute("ppl");
                                }
                                if (!pp.isEmpty()) {
                                    for (ProductionPlanHolder p : pp) {

                                        ProductionSteps ps = new ProductionSteps();
                                        ps.setItems(ITEM);
                                        ps.setStepName(p.getName());
                                        ps.setStatus(1);
                                        ses.save(ps);

                                        ItemStaffCost ic = new ItemStaffCost();
                                        ic.setItems(ITEM);
                                        ic.setProductionSteps(ps);
                                        ic.setCost(p.getCost());
                                        ic.setStatus(1);
                                        ses.save(ic);

                                    }

                                }

                                ArrayList<ProductionRawMatHolder> pph = new ArrayList();
                                if (request.getSession().getAttribute("rrl") != null) {
                                    pph = (ArrayList<ProductionRawMatHolder>) request.getSession().getAttribute("rrl");
                                    request.getSession().removeAttribute("rrl");
                                }

                                if (!pph.isEmpty()) {
                                    for (ProductionRawMatHolder p : pph) {
                                        RawItems RI = (RawItems) ses.load(RawItems.class, p.getRow_id());
                                        ItemsHasRawItems ir = new ItemsHasRawItems();
                                        ir.setItems(ITEM);
                                        ir.setRawItems(RI);
                                        ir.setAmount(p.getAmount());
                                        ir.setStatus(1);
                                        ses.save(ir);
                                    }

                                }

                                tr.commit();
                                ses.close();
                                out.print("1");
                            } else {
                                System.out.println("B");
                                out.print("0");
                            }

                        }
                    }

                }

            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("C");
            out.print("0");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
