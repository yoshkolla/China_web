/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package help;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

/**
 *
 * @author Mayura Lakshan
 */
public class Helper {
    
    public static String getDate() {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Calendar cal = Calendar.getInstance();
        return dateFormat.format(cal.getTime());

    }

    public static String getTime() {
        DateFormat datetime = new SimpleDateFormat("HH:mm:ss");
        Calendar cal = Calendar.getInstance();
        return datetime.format(cal.getTime());

    }
    
    
}
