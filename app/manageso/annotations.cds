using CatalogService as service from '../../srv/CatalogService';

// ─── Sales Orders ────────────────────────────────────────────────────────────

annotate service.SalesOrders with @(

    UI.SelectionFields: [
        orderNo,
        customer_ID,
        customer.name,
        totalAmount,
        status,
        OVERALL_STATUS
    ],

    UI.LineItem: [
        {
            $Type: 'UI.DataField',
            Value: orderNo,
            Label: 'Order No', // ADDED: label
        },
        {
            $Type: 'UI.DataField',
            Value: customer_ID,
            Label: 'Customer ID', // ADDED: label
        },
        {
            $Type: 'UI.DataField',
            Value: totalAmount,
            Label: 'Total Amount', // ADDED: label
        },
        {
            $Type: 'UI.DataField',
            Value: deliveryDate,
            Label: 'Delivery Date', // ADDED: label
        },
        {
            $Type: 'UI.DataField',
            Value: OverallStatusText,
            Label: 'Overall Status', // ADDED: label
        },
        {
            $Type      : 'UI.DataField',
            Value      : OverallStatusText,
            Criticality: IconColor,
            Label      : 'Status Indicator', // ADDED: label
        },
    ],

    UI.HeaderInfo: {
        TypeName      : 'Sales Order',
        TypeNamePlural: 'Sales Orders',
        Title         : {Value: orderNo},
        Description   : {Value: customer.name},
    },

    UI.Facets: [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Additional Info',
            Facets: [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Order Details',
                    Target: '@UI.Identification',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Pricing Details',
                    Target: '@UI.FieldGroup#PricingInfo',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Status Info',
                    Target: '@UI.FieldGroup#StatusInfo',
                },
            ],
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Order Items',
            Target: 'items/@UI.LineItem',
        },
    ],

    UI.Identification: [
        {
            $Type: 'UI.DataField',
            Value: orderNo,
            Label: 'Order No', // ADDED: label
        },
        {
            $Type: 'UI.DataField',
            Value: customer_ID,
            Label: 'Customer ID', // ADDED: label
        },
        {
            $Type: 'UI.DataField',
            Value: status,
            Label: 'Status', // ADDED: label
        },
        {
            $Type: 'UI.DataField',
            Value: deliveryDate,
            Label: 'Delivery Date', // ADDED: label
        },
        {
            $Type : 'UI.DataFieldForAction',
            Label : 'Approve',
            Action: 'CatalogService.SalesOrdersApprove',
            ![@UI.Hidden]: {
                $edmJson: {
                    $And: [
                        {$Ne: [{$Path: 'OVERALL_STATUS'}, 'N']},
                        {$Ne: [{$Path: 'OVERALL_STATUS'}, 'P']}
                    ]
                }
            },
        }
    ],

    UI.FieldGroup #PricingInfo: {
        Label: 'Pricing',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: totalAmount,
                Label: 'Total Amount', // ADDED: label
            },
        ],
    },

    UI.FieldGroup #StatusInfo: {
        Label: 'Status Info',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: status,
                Label: 'Status', // ADDED: label
            },
            {
                $Type: 'UI.DataField',
                Value: OverallStatusText,
                Label: 'Overall Status', // ADDED: label
            },
            {
                $Type: 'UI.DataField',
                Value: OVERALL_STATUS,
                Label: 'Overall Status Code', // ADDED: label
            },
        ],
    },
);

// ─── SO Items ────────────────────────────────────────────────────────────────

annotate service.SalesOrderItems with @(

    UI.LineItem: [
        {
            $Type: 'UI.DataField',
            Value: lineNo,
            Label: 'Line No',
        },
        {
            $Type: 'UI.DataField',
            Value: product_ID,
            Label: 'Product ID',
        },
        {
            $Type: 'UI.DataField',
            Value: quantity,
            Label: 'Quantity',
        },
        {
            $Type: 'UI.DataField',
            Value: uom,
            Label: 'UoM',
        },
        {
            $Type: 'UI.DataField',
            Value: unitPrice,
            Label: 'Unit Price',
        },
        {
            $Type: 'UI.DataField',
            Value: totalPrice,
            Label: 'Total Price',
        },
    ],

    UI.HeaderInfo: {
        TypeName      : 'Order Item',
        TypeNamePlural: 'Order Items',
        Title         : {Value: lineNo},
        Description   : {Value: product.name},
    },

    UI.Facets: [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Item Details',
            Target: '@UI.Identification',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Product Details',
            Target: '@UI.FieldGroup#ProdInfo',
        },
    ],

    UI.Identification: [
        {
            $Type: 'UI.DataField',
            Value: lineNo,
            Label: 'Line No', // ADDED: label
        },
        {
            $Type: 'UI.DataField',
            Value: product_ID,
            Label: 'Product ID', // ADDED: label
        },
        {
            $Type: 'UI.DataField',
            Value: quantity,
            Label: 'Quantity', // ADDED: label
        },
        {
            $Type: 'UI.DataField',
            Value: uom,
            Label: 'UoM', // ADDED: label
        },
        {
            $Type: 'UI.DataField',
            Value: unitPrice,
            Label: 'Unit Price', // ADDED: label
        },
        {
            $Type: 'UI.DataField',
            Value: totalPrice,
            Label: 'Total Price', // ADDED: label
        },
        {
            $Type: 'UI.DataField',
            Value: plant_ID,
            Label: 'Dispatch Plant', // ADDED: label
        },
    ],

    UI.FieldGroup #ProdInfo: {
        Label: 'Product Info',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: lineNo,
                Label: 'Line No',
            },
            {
                $Type: 'UI.DataField',
                Value: product_ID,
                Label: 'Product ID',
            },
            {
                $Type: 'UI.DataField',
                Value: product.name,
                Label: 'Product Name',
            },
            {
                $Type: 'UI.DataField',
                Value: product.category,
                Label: 'Category',
            },
            {
                $Type: 'UI.DataField',
                Value: product.baseUoM,
                Label: 'Base UoM',
            },
            {
                $Type: 'UI.DataField',
                Value: plant_ID,
                Label: 'Dispatch Plant',
            },
        ],
    },
);

// ─── Associations, Text & ValueList ──────────────────────────────────────────

// NOTE: Do NOT add odata.draft.enabled here — it is already declared in
//       CatalogService.cds on the SalesOrders projection. Declaring it a
//       second time causes the UI to always open in Draft mode and
//       suppresses the Edit button on saved records.

annotate service.SalesOrders with {
    customer @(
        Common.Text           : customer.name,
        Common.TextArrangement: #TextOnly,
        Common.ValueList      : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'BusinessPartners',
            Parameters    : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : customer_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'role',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'creditLimit',
                },
            ],
        }
    );
    OVERALL_STATUS @(
        Common.Text           : OverallStatusText,
        Common.TextArrangement: #TextOnly
    );
};

annotate service.SalesOrderItems with {
    product @(
        Common.Text           : product.name,
        Common.TextArrangement: #TextOnly
    );
    plant @(
        Common.Text           : plant.name,
        Common.TextArrangement: #TextOnly
    );
};



