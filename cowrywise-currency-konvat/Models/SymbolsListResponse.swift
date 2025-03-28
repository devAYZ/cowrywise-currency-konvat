//
//  SymbolsListResponse.swift
//  cowrywise-currency-konvat
//
//  Created by Ayokunle Fatokimi on 28/03/2025.
//

import Foundation

struct SymbolsListResponse: Decodable {
    var success: Bool?
    var error: ErrorResponse?
    var symbols: SymbolsList?
}

struct SymbolsList: Decodable {
    
    var MAD, GEL, VUV, PLN, CAD, LKR, AMD, GTQ, KPW, CLP, MGA, SOS, MNT, ILS, UGX, BRL, KZT, GBP, BTC, JMD, ARS, CUC, XOF, SDG, PKR, WST, BAM, KHR, KMF, XPF, BYR, BND, CNY, FKP, CVE, XAU, HKD, JOD, SYP, PGK, TTD, RWF, DJF, BBD, CZK, XCD, CLF, IMP, SBD, BHD, VEF, MDL, ETB, KRW, VND, TZS, XAG, CRC, XAF, TOP, MXN, LTL, RSD, BZD, SAR, OMR, KGS, LAK, BOB, TMT, LVL, UYU, ANG, GHS, PEN, THB, MKD, UAH, SZL, BWP, CNH, IRR, JPY, BGN, INR, BYN, IQD, ERN, BDT, PYG, FJD, AWG, LBP, CDF, LRD, ZAR, NIO, SCR, NZD, BMD, DZD, AFN, NPR, BIF, NAD, ZMW, DKK, RUB, SEK, AOA, RON, KYD, GYD, UZS, ISK, TRY, KES, COP, AZN, GMD, NGN, MVR, SLL, USD, HUF, LSL, MMK, STD, MZN, ZMK, TJS, KWD, BTN, DOP, CHF, SGD, YER, TWD, TND, PHP, SRD, SLE, MYR, BSD, LYD, ZWL, QAR, NOK, ALL, EGP, MOP, EUR, GIP, AUD, HNL, JEP, SHP, MWK, HRK, PAB, SVC, XDR, MUR, GNF, AED, GGP, CUP, HTG, IDR, MRU, VES: String?
}
