using { API_BUSINESS_PARTNER as bupa } from '../srv/external/API_BUSINESS_PARTNER';

entity Suppliers as projection on bupa.A_BusinessPartner {
    key BusinessPartner as ID,
    BusinessPartnerName as fullName,
    BusinessPartnerIsBlocked as isBlocked
}