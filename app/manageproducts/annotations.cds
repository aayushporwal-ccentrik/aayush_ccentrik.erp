using CatalogService as service from '../../srv/CatalogService';

annotate service.Products with @(

    UI.SelectionFields: [
        name,
        category,
        baseUoM
    ],

    UI.LineItem: [
        {
            $Type             : 'UI.DataField',
            Value             : imageUrl,
            Label             : 'Image',
            ![@UI.Importance] : #High
        },
        {
            $Type: 'UI.DataField',
            Value: name,
            Label: 'Product Name',
        },
        {
            $Type: 'UI.DataField',
            Value: category,
            Label: 'Category',
        },
        {
            $Type: 'UI.DataField',
            Value: baseUoM,
            Label: 'Base UoM',
        },
    ],

    UI.HeaderInfo: {
        TypeName      : 'Product',
        TypeNamePlural: 'Products',
        Title         : { Value: name },
        Description   : { Value: category },
        ImageUrl      : imageUrl
    },

    UI.Facets: [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Product Details',
            Facets: [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'General Information',
                    Target: '@UI.Identification'
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Specifications',
                    Target: '@UI.FieldGroup#ProductSpecs'
                },
            ],
        }
    ],

    UI.Identification: [
        {
            $Type: 'UI.DataField',
            Value: name,
            Label: 'Product Name',
        },
        {
            $Type: 'UI.DataField',
            Value: category,
            Label: 'Category',
        },
        {
            $Type: 'UI.DataField',
            Value: baseUoM,
            Label: 'Base Unit of Measure',
        },
    ],

    UI.FieldGroup #ProductSpecs: {
        Label: 'Specifications',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: name,
                Label: 'Product Name',
            },
            {
                $Type: 'UI.DataField',
                Value: category,
                Label: 'Category',
            },
            {
                $Type: 'UI.DataField',
                Value: baseUoM,
                Label: 'Base UoM',
            },
        ]
    },
);

annotate service.Products with @(
    odata.draft.enabled: true
);

annotate service.Products with {
    @UI.IsImageUrl: true
    imageUrl
};