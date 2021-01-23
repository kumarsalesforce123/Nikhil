import { LightningElement, api, wire } from 'lwc';
import getAccountList from '@salesforce/apex/exportToCSVTool.getAccountList';
export default class ExportToCSVTool extends LightningElement {

    @api
    objectApi = '';
    @api
    fields = '';
    @api
    where = '';
    @api
    limit = '';
    @api
    fileName = 'result';

    //accountList = [];

    handleExport(evnt){
        console.log(this.objectApi,this.fields,this.where,this.limit);
        getAccountList({objectApi:this.objectApi,fields:this.fields,condetions:this.where,recordslimit:this.limit})
            .then(result => {
                //this.accountList = result;
                let csv = this.convertArrayOfObjectsToCSV(result,this.fields);   
                let csvName = this.fileName;
                if (csv == null){return;}                 
                let hiddenElement = document.createElement('a');
                hiddenElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csv);
                hiddenElement.target = '_self';  
                hiddenElement.download = csvName+'.csv';  
                document.body.appendChild(hiddenElement);
                hiddenElement.click(); 
            })
            .catch(err => {
                console.error(err);
            });
    }
    convertArrayOfObjectsToCSV(objectRecords,keys){
        var csvStringResult, counter, columnDivider, lineDivider, fields;

        if (objectRecords && objectRecords.length && keys) {
            keys = keys.replaceAll(' ','');
            fields = keys.split(",");
            columnDivider = ',';
            lineDivider =  '\n';       
            csvStringResult = '';
            if(fields)
            {
                csvStringResult += keys;
                csvStringResult += lineDivider;
                for(let i=0; i < objectRecords.length; i++)
                {
                    let colValue = 0;
                    fields.forEach((key)=>{
                        if(colValue > 0){
                            csvStringResult += ',';
                        }
                        let value = objectRecords[i][key] === undefined ? '' : objectRecords[i][key];
                        csvStringResult += '"'+ value +'"';
                        colValue++;   
                    });
                        csvStringResult += lineDivider;
                  }         
                return csvStringResult;  
            } 
        }        
        return null;              
    }
    /*
    @wire(getAccountList, {objectApi:'$objectApi',fields:'$fields',condetions:'$where',recordslimit:'$limit'})
    getrecords({err,result})
    {
        console.log(this.objectApi,this.fields,this.where,this.limit);
        if(result)
        {
            this.accountList = result;
        }
        else if(err)
        {
            console.error(err);
        }
    }*/
}