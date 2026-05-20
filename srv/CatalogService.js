const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
    const { SalesOrders } = this.entities;

    this.on('SalesOrdersApprove', SalesOrders, async (req) => {
        const { ID } = req.params[0];  // ✅ get ID from params

        await UPDATE(SalesOrders)
            .set({ OVERALL_STATUS: 'A' })  // ✅ correct field and value
            .where({ ID });
        req.notify(200, 'Sales Order Approved Successfully');
        return SELECT.one.from(SalesOrders).where({ ID });  // ✅ return updated record
    });

});