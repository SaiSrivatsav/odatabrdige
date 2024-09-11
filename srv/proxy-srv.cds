namespace odatabridge.srv;
using { API_GLOBAL_JET } from './external/API_GLOBAL_JET';
using { odatabridge.db } from '../db/proxy-models';

service GlobalJetService @(path:'GlobalJetService'){
    entity CompanyCodes as projection on API_GLOBAL_JET.CompanyCodesSet;
    entity GlAccounts as projection on API_GLOBAL_JET.GLAccountsSet;
    entity CreateJournal as projection on db.HeaderData;
    entity Items as projection on db.ItemData;
    entity ColumnData as projection on db.Columns;
    entity CreateFIDoc as projection on db.ProxyInput;
}



