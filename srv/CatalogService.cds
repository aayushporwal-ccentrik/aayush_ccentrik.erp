using {com.cement.erp.master, com.cement.erp.transaction} from '../db/data-model';


Service CatalogService @(path: 'CatalogService', requires:'authenticated-user') {
    
    // ─── Master Data ──────────────────────────────────────────────────
    @(restrict:[
        {grant: ['READ'], to: 'Viewer'},
        {grant: ['WRITE'], to: 'Editor'}
    ])
    entity Products       as projection on master.Products;
    entity Plants         as projection on master.Plants;
    entity BusinessPartners as projection on master.BusinessPartners;

    // ─── Purchase Orders ──────────────────────────────────────────────

    entity PurchaseOrders     as projection on transaction.PurchaseOrders;
    entity PurchaseOrderItems as projection on transaction.PurchaseOrderItems;

    // ─── Production Orders ────────────────────────────────────────────

    entity ProductionOrders     as projection on transaction.ProductionOrders;
    entity ProductionOrderItems as projection on transaction.ProductionOrderItems;
    entity KilnLogs             as projection on transaction.KilnLogs;
    entity QualityAssurance     as projection on transaction.QualityAssurance;

    // ─── Sales Orders ─────────────────────────────────────────────────

    
    @odata.draft.enabled 
    @cds.redirection.target  // ADDED: marks SalesOrders as primary redirection target
    entity SalesOrders as projection on transaction.SalesOrders{
    *,
    //Add labels 
     case
        when OVERALL_STATUS = 'A' then 'Approved'
        when OVERALL_STATUS = 'X' then 'Rejected'
        when OVERALL_STATUS = 'N' then 'New'
        when OVERALL_STATUS = 'P' then 'Pending'
        else 'Pending'
    end as OverallStatusText : String,
    case
        when OVERALL_STATUS = 'A' then 3
        when OVERALL_STATUS = 'X' then 1
        when OVERALL_STATUS = 'N' then 2
        when OVERALL_STATUS = 'P' then 2
        else 2
    end as IconColor : Integer
}
actions{
    action SalesOrdersApprove() returns SalesOrders;
    };

    entity SalesOrderItems as projection on transaction.SalesOrderItems;

    // ADDED: Separate read-only projection for Sales Analytics — no draft, no actions
// CHANGED: Added Aggregation annotation so Fiori generator accepts SalesAnalytics for ALP
@readonly
@Aggregation.ApplySupported: {
    Transformations        : ['aggregate', 'groupby', 'filter'],
    GroupableProperties    : [status, OVERALL_STATUS, deliveryDate, customer_ID],
    AggregatableProperties : [{Property: totalAmount}, {Property: orderNo}]
}
entity SalesAnalytics as projection on transaction.SalesOrders {
    *,
    case
        when OVERALL_STATUS = 'A' then 'Approved'
        when OVERALL_STATUS = 'X' then 'Rejected'
        when OVERALL_STATUS = 'N' then 'New'
        when OVERALL_STATUS = 'P' then 'Pending'
        else 'Pending'
    end as OverallStatusText : String,
    case
        when OVERALL_STATUS = 'A' then 3
        when OVERALL_STATUS = 'X' then 1
        when OVERALL_STATUS = 'N' then 2
        when OVERALL_STATUS = 'P' then 2
        else 2
    end as IconColor : Integer
};

    // ─── Inventory & Logistics ────────────────────────────────────────

    entity InventoryStock      as projection on transaction.InventoryStock;
    entity WeighbridgeTickets  as projection on transaction.WeighbridgeTickets;
            };

annotate CatalogService.Products with {
  @UI.IsImageUrl : true
  @Core.IsURL    : true
  @Core.MediaType: 'image/jpg'
  imageUrl
};




