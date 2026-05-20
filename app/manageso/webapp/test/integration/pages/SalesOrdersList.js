sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'com.aayush.so.manageso',
            componentId: 'SalesOrdersList',
            contextPath: '/SalesOrders'
        },
        CustomPageDefinitions
    );
});