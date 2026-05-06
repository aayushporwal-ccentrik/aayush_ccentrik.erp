sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'com.cements.erp.plants.manageplants',
            componentId: 'PlantsList',
            contextPath: '/Plants'
        },
        CustomPageDefinitions
    );
});