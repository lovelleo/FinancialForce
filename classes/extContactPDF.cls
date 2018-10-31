/*
    Extension Class to for FinancialForce.page, FinancialForcePDF and FinancialForceXLS
*/
public with sharing class extContactPDF {
   // Wrapper to get content as PDF or XLS
   public List<wrapPDFList> lstPDFList{get; set;} 
   // List for xls
   public List<Contact> lstCon {get; set;}
   // Constructor 
   public extContactPDF(ApexPages.StandardController stdCntrlr){
        try{
            lstCon = new List<Contact>();
            lstPDFList = new  List<wrapPDFList>();
            lstCon =  [Select name, Account.Name, Phone from Contact where Account.Name != null and Phone != null Order by Account.Name desc limit 50000];
            integer count = 1;
            for(integer i=0; i<lstCon.size(); i=i+10){
                wrapPDFList wrapObj = new wrapPDFList();
                List<Contact> templstCon = new  List<Contact>();
                for(integer j=0;j<9;j++){
                    templstCon.add(lstCon[i]);
                }
                wrapObj.lstPdfContact = templstCon;
                wrapObj.pagecount = count;
                lstPDFList.add(wrapObj);
                count++;
                system.debug('lstPDFList---' + lstPDFList);
            } 
        }
        catch(DmlException dex){
            system.debug('Error---' + dex.getMessage() + '--Line--'+ dex.getLineNumber());
        }
        catch(Exception ex){
            system.debug('Error---' + ex.getMessage() + '--Line--'+ ex.getLineNumber());
        }
    }
    // Wrapper to get content as PDF or XLS
    public class wrapPDFList {
        public integer pagecount{get; set;}
        public List<Contact> lstPdfContact {get; set;}
    }
}