/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package holder;

import java.util.ArrayList;
import resources.InvoiceItem;

/**
 *
 * @author SCORFi3LD
 */
public class InvoiceItemHolder {

    private ArrayList<InvoiceItem> holder = new ArrayList();

    /**
     * @return the holder
     */
    public ArrayList<InvoiceItem> getHolder() {
        return holder;
    }

    public void printAll() {
        if (!holder.isEmpty()) {
            System.out.println("================================================");
            for (InvoiceItem item : holder) {
                System.out.println("Stock ID :\t" + item.getStock().getStockId());
                System.out.println("Qty :\t" + item.getQty());
            }
            System.out.println("================================================");
        }
    }
    
    public void clear(){
        this.holder.clear();
    }
}
