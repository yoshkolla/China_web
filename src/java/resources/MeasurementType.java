package resources;
// Generated Mar 22, 2020 2:49:48 AM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * MeasurementType generated by hbm2java
 */
public class MeasurementType  implements java.io.Serializable {


     private Integer measurementTypeId;
     private String name;
     private Integer status;
     private Set itemses = new HashSet(0);
     private Set rawItemses = new HashSet(0);

    public MeasurementType() {
    }

    public MeasurementType(String name, Integer status, Set itemses, Set rawItemses) {
       this.name = name;
       this.status = status;
       this.itemses = itemses;
       this.rawItemses = rawItemses;
    }
   
    public Integer getMeasurementTypeId() {
        return this.measurementTypeId;
    }
    
    public void setMeasurementTypeId(Integer measurementTypeId) {
        this.measurementTypeId = measurementTypeId;
    }
    public String getName() {
        return this.name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    public Integer getStatus() {
        return this.status;
    }
    
    public void setStatus(Integer status) {
        this.status = status;
    }
    public Set getItemses() {
        return this.itemses;
    }
    
    public void setItemses(Set itemses) {
        this.itemses = itemses;
    }
    public Set getRawItemses() {
        return this.rawItemses;
    }
    
    public void setRawItemses(Set rawItemses) {
        this.rawItemses = rawItemses;
    }




}


