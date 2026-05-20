sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'com.aayush.sa.salesanalyis',
            componentId: 'SalesAnalyticsList',
            contextPath: '/SalesAnalytics'
        },
        CustomPageDefinitions
    );
});