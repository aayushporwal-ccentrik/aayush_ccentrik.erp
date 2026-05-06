sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"com/cements/erp/plants/manageplants/test/integration/pages/PlantsList",
	"com/cements/erp/plants/manageplants/test/integration/pages/PlantsObjectPage"
], function (JourneyRunner, PlantsList, PlantsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('com/cements/erp/plants/manageplants') + '/test/flp.html#app-preview',
        pages: {
			onThePlantsList: PlantsList,
			onThePlantsObjectPage: PlantsObjectPage
        },
        async: true
    });

    return runner;
});

