using CatalogService.SalesAnalytics as service from '../../srv/CatalogService';

// ADDED: Tell ALP how to aggregate totalAmount
annotate CatalogService.SalesAnalytics with @(
    Analytics.AggregatedProperties : [{
        Name                 : 'totalRevenue',
        AggregationMethod    : 'sum',
        AggregatableProperty : totalAmount,
        ![@UI.DataPoint]     : {
            Title : 'Total Revenue'
        }
    }]
);

annotate CatalogService.SalesAnalytics with @(

    UI.DataPoint #totalAmount : {
        Value : totalAmount,
        Title : 'Total Revenue'
    },

    // CHANGED: Measures now references the aggregated property 'totalRevenue'
    UI.Chart #salesChart1 : {
        Title             : 'Sales by Status',
        ChartType         : #Bar,       
        Dimensions        : [status],
        Measures          : [totalRevenue],
        MeasureAttributes : [{
            Measure   : totalRevenue,
            Role      : #Axis1,
            DataPoint : '@UI.DataPoint#totalAmount'
        }]
    },

    UI.PresentationVariant : {
        Visualizations : ['@UI.Chart#salesChart1', '@UI.LineItem']
    },

    UI.LineItem : [
        { Value : orderNo,           Label : 'Order No'     },
        { Value : status,            Label : 'Status'       },
        { Value : totalAmount,       Label : 'Total Amount' },
        { Value : deliveryDate,      Label : 'Delivery Date'},
        { Value : OverallStatusText, Label : 'Approval'     }
    ],

    UI.SelectionFields : [status, deliveryDate, OVERALL_STATUS]
);