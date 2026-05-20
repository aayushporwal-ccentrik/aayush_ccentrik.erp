sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"com/aayush/so/manageso/test/integration/pages/SalesOrdersList",
	"com/aayush/so/manageso/test/integration/pages/SalesOrdersObjectPage",
	"com/aayush/so/manageso/test/integration/pages/SalesOrderItemsObjectPage"
], function (JourneyRunner, SalesOrdersList, SalesOrdersObjectPage, SalesOrderItemsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('com/aayush/so/manageso') + '/test/flp.html#app-preview',
        pages: {
			onTheSalesOrdersList: SalesOrdersList,
			onTheSalesOrdersObjectPage: SalesOrdersObjectPage,
			onTheSalesOrderItemsObjectPage: SalesOrderItemsObjectPage
        },
        async: true
    });

    return runner;
});

