/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package holder;

import java.util.ArrayList;

/**
 *
 * @author AKILA
 */
public class GRNItems_DataHolder {

    private ArrayList<GRN_ITEM_OBJ> dataHolder = new ArrayList();

    public ArrayList<GRN_ITEM_OBJ> getHolder() {
        return dataHolder;
    }

    public void clear() {
        this.dataHolder.clear();
    }

    public void printAll() {
        if (!dataHolder.isEmpty()) {
            System.out.println("================================================");
            for (GRN_ITEM_OBJ grnItem : dataHolder) {
                System.out.println("RawItemID :\t" + grnItem.getRawItem() + " | " + grnItem.getRawItem().getRawItemsId() + " | " + grnItem.getRawItem().getName());
                System.out.println("UnitPrice :\t" + grnItem.getUnitPrice());
                System.out.println("Qty :\t" + grnItem.getQty());
                System.out.println("Amount :\t" + grnItem.getAmount());
                System.out.println("Discount :\t" + grnItem.getDiscount());
                System.out.println("TotalAmount :\t" + grnItem.getTotalAmount());
            }
            System.out.println("================================================");
        }
    }
}
