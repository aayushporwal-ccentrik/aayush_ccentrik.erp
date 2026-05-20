sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"com/aayush/sa/salesanalyis/test/integration/pages/SalesAnalyticsList",
	"com/aayush/sa/salesanalyis/test/integration/pages/SalesAnalyticsObjectPage",
	"com/aayush/sa/salesanalyis/test/integration/pages/SalesOrderItemsObjectPage"
], function (JourneyRunner, SalesAnalyticsList, SalesAnalyticsObjectPage, SalesOrderItemsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('com/aayush/sa/salesanalyis') + '/test/flp.html#app-preview',
        pages: {
			onTheSalesAnalyticsList: SalesAnalyticsList,
			onTheSalesAnalyticsObjectPage: SalesAnalyticsObjectPage,
			onTheSalesOrderItemsObjectPage: SalesOrderItemsObjectPage
        },
        async: true
    });

    return runner;
});

