namespace odatabridge.db;

//Original Payload
entity HeaderData {
        Approver     : String(12);
        LedgerGroup  : String(4);
    key JournalNo    : String(10);
        ParkedDocNo  : String(10);
    key Action       : String(10);
        DocHeaderTxt : String(50);
        DocType      : String(2);
        Username     : String(12);
        CompCode     : String(4);
        PostingDate  : DateTime;
        Period       : String(2);
        Currency     : String(5);
        Items        : Composition of many ItemData
                           on Items.parentHeaderData = $self;
}

entity ItemData {
    key Index            : String;
        ColumnData       : Composition of many Columns
                               on ColumnData.parentItemData = $self;
        parentHeaderData : Association to HeaderData
}

entity Columns {
    key Columnname     : String(10);
        Value          : String;
        parentItemData : Association to ItemData
}

//Proxy Input Payload

entity ProxyInput {
        Approver     : String(12);
        LedgerGroup  : String(4);
    key JournalNo    : String(10);
        ParkedDocNo  : String(10);
    key Action       : String(10);
        DocHeaderTxt : String(50);
        DocType      : String(2);
        Username     : String(12);
        CompCode     : String(4);
        PostingDate  : DateTime;
        Period       : String(2);
        Currency     : String(5);
        Items        : Composition of many ItemInfo
                           on Items.parentHeaderData = $self;
}

entity ItemInfo {
    key BSCHL            : String;
    key KONTO            : String;
    key WRBTR            : String;
        MWSKZ            : String;
        ZUONR            : String;
        SGTXT            : String;
        VBUND            : String;
        KOSTL            : String;
        PRCTR            : String;
        AUFNR            : String;
        PROJN            : String;
        ZZDIVISION       : String;
        ZZCOUNTRY        : String;
        BZDAT            : String;
        VALUT            : String;
        ZFBDT            : String;
        ZTERM            : String;
        ZBD1T            : String;
        ZBD2T            : String;
        ZBD3T            : String;
        ZBD1P            : String;
        ZBD2P            : String;
        ZBFIX            : String;
        ZLSCH            : String;
        ZLSPR            : String;
        MSCHL            : String;
        MANSP            : String;
        MATNR            : String;
        MENGE            : String;
        MEINS            : String;
        HBKID            : String;
        BUPLA            : String;
        NEWBK            : String;
        GRICD            : String;
        GRIRG            : String;
        GITYP            : String;
        PERNR            : String;
        FWBAS            : String;
        UZAWE            : String;
        BVTYP            : String;
        KIDNO            : String;
        TXJCD            : String;
        ZUMSK            : String;
        XNEGP            : String;
        WERKS            : String;
        VATDATE          : String;
        SELLERID         : String;
        SELLJOUR         : String;
        LDGRP            : String;
        parentHeaderData : Association to ProxyInput
}
