sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"com/cements/erp/products/manageproducts/test/integration/pages/ProductsList",
	"com/cements/erp/products/manageproducts/test/integration/pages/ProductsObjectPage"
], function (JourneyRunner, ProductsList, ProductsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('com/cements/erp/products/manageproducts') + '/test/flp.html#app-preview',
        pages: {
			onTheProductsList: ProductsList,
			onTheProductsObjectPage: ProductsObjectPage
        },
        async: true
    });

    return runner;
});

