using {com.cement.erp.master, com.cement.erp.transaction} from '../db/data-model';


Service CatalogService @(path: 'CatalogService') {
    
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

    entity SalesOrders     as projection on transaction.SalesOrders;
    entity SalesOrderItems as projection on transaction.SalesOrderItems;

    // ─── Inventory & Logistics ────────────────────────────────────────

    entity InventoryStock      as projection on transaction.InventoryStock;
    entity WeighbridgeTickets  as projection on transaction.WeighbridgeTickets;
            }