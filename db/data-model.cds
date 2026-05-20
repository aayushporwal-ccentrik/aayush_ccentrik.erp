namespace com.cement.erp;

using {
  managed,
  cuid
} from '@sap/cds/common';

using {com.cement.commons} from './commons';

context master {

  entity Products : cuid, managed {
    name     : String(100);
    category : commons.category;
    baseUoM  : String(3);
    @UI.IsImageUrl : true
    imageUrl     : String; 
  }

  entity Plants : cuid, managed {
    name              : String(100);
    location          : String(100);
    totalSiloCapacity : Decimal(15, 2);
    inventory         : Association to many transaction.InventoryStock
                          on inventory.plant = $self;
  }

  entity BusinessPartners : cuid, managed {
    name        : String(100);
    role        : String(20); // Supplier, Customer, Dealer
    creditLimit : Decimal(15, 2);
  }

}

context transaction {

  // ─── Purchase Orders ──────────────────────────────────────────────
  entity PurchaseOrders : cuid, managed {
    orderNo      : String(20);
    status       : String(20); // Draft, Approved, Received
    orderDate    : Date;
    expectedDate : Date;
    supplier     : Association to master.BusinessPartners;

    // Each PO can have multiple line items (different materials)
    items        : Composition of many PurchaseOrderItems
                     on items.purchaseOrder = $self;
  }

  entity PurchaseOrderItems : cuid {
    purchaseOrder : Association to PurchaseOrders;
    lineNo        : Integer;       // Line 1, Line 2 ...
    product       : Association to master.Products;
    quantity      : Decimal(15, 2);
    uom           : commons.UoM;
    unitPrice     : Decimal(15, 2);
    totalPrice    : Decimal(15, 2);
    plant         : Association to master.Plants; // deliver to which plant
  }

  // ─── Production Orders ────────────────────────────────────────────
  entity ProductionOrders : cuid, managed {
    orderNo     : String(20);
    targetQty   : Decimal(15, 2);
    status      : String(20); // Draft, In-Progress, Completed
    startDate   : DateTime;
    endDate     : DateTime;
    product     : Association to master.Products;
    plant       : Association to master.Plants;

    // Line items — components consumed to make the product
    items       : Composition of many ProductionOrderItems
                    on items.productionOrder = $self;

    kilnLogs    : Composition of many KilnLogs
                    on kilnLogs.productionOrder = $self;
    qualityLogs : Composition of many QualityAssurance
                    on qualityLogs.productionOrder = $self;
  }

  entity ProductionOrderItems : cuid {
    productionOrder  : Association to ProductionOrders;
    lineNo           : Integer;
    component        : Association to master.Products; // e.g. Limestone, Gypsum
    requiredQty      : Decimal(15, 2);
    actualQty        : Decimal(15, 2); // what was actually consumed
    uom              : commons.UoM;
  }

  // ─── Sales Orders ─────────────────────────────────────────────────
  entity SalesOrders : cuid, managed {
    orderNo      : String(20);
    totalAmount  : Decimal(15, 2);
    status       : String(20); // Draft, Confirmed, Dispatched, Delivered
    deliveryDate : Date;
    customer     : Association to master.BusinessPartners;
    OVERALL_STATUS: String(1); // N-New, A-Approved, X-Rejected, else Pending
    // Each SO can sell multiple products in one order
    items        : Composition of many SalesOrderItems
                     on items.salesOrder = $self;
  }

  entity SalesOrderItems : cuid {
    salesOrder  : Association to SalesOrders;
    lineNo      : Integer;
    product     : Association to master.Products;
    quantity    : Decimal(15, 2);
    uom         : commons.UoM;
    unitPrice   : Decimal(15, 2);
    totalPrice  : Decimal(15, 2);
    plant       : Association to master.Plants; // dispatch from which plant
  }

  // ─── Supporting entities (unchanged) ─────────────────────────────

  entity KilnLogs : cuid {
    productionOrder : Association to ProductionOrders;
    temperature     : Decimal(7, 2);
    fuelConsumption : Decimal(10, 2);
    rotationSpeed   : Decimal(5, 2);
    timestamp       : DateTime;
  }

  entity QualityAssurance : cuid {
    productionOrder      : Association to ProductionOrders;
    testDate             : DateTime;
    isPassed             : Boolean;
    limeSaturationFactor : Decimal(5, 2);
    silicaModulus        : Decimal(5, 2);
    strength28Day        : Decimal(5, 2);
  }

  entity WeighbridgeTickets : cuid, managed {
    ticketNo  : String(30);
    vehicleNo : String(20);
    inWeight  : Decimal(10, 3);
    outWeight : Decimal(10, 3);
    netWeight : Decimal(10, 3);
    timestamp : DateTime;

    // linked to either a PO receipt or SO dispatch
    purchaseOrderItem : Association to PurchaseOrderItems;
    salesOrderItem    : Association to SalesOrderItems;
  }

  entity InventoryStock : cuid, managed {
    currentStock  : Decimal(15, 2);
    reservedStock : Decimal(15, 2);
    plant         : Association to master.Plants;
    product       : Association to master.Products;
  }

}