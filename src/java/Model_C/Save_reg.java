/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model_C;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import resources.Customer;

/**
 *
 * @author Chamara
 */
public class Save_reg {

    static SessionFactory sf;

    public Save_reg() {
        sf = connection.GetConnection.getSessionFactory();
    }

    public String Save_Cus(Customer cus) {
        Session ses = sf.openSession();
        Transaction tr = ses.beginTransaction();
        ses.save(cus);
        tr.commit();
        ses.flush();
        ses.close();
        return "Done";
    }
}
