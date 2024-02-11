// ignore_for_file: constant_identifier_fullNames

enum USState {
  AL(fullName: "Alabama"),
  AK(fullName: "Alaska"),
  AZ(fullName: "Arizona"),
  AR(fullName: "Arkansas"),
  CA(fullName: "California"),
  CO(fullName: "Colorado"),
  CT(fullName: "Connecticut"),
  DC(fullName: "District of Columbia"),
  DE(fullName: "Delaware"),
  FL(fullName: "Florida"),
  GA(fullName: "Georgia"),
  HI(fullName: "Hawaii"),
  ID(fullName: "Idaho"),
  IL(fullName: "Illinois"),
  IN(fullName: "Indiana"),
  IA(fullName: "Iowa"),
  KS(fullName: "Kansas"),
  KY(fullName: "Kentucky"),
  LA(fullName: "Louisiana"),
  ME(fullName: "Maine"),
  MD(fullName: "Maryland"),
  MA(fullName: "Massachusetts"),
  MI(fullName: "Michigan"),
  MN(fullName: "Minnesota"),
  MS(fullName: "Mississippi"),
  MO(fullName: "Missouri"),
  MT(fullName: "Montana"),
  NE(fullName: "Nebraska"),
  NV(fullName: "Nevada"),
  NH(fullName: "New Hampshire"),
  NJ(fullName: "New Jersey"),
  NM(fullName: "New Mexico"),
  NY(fullName: "New York"),
  NC(fullName: "North Carolina"),
  ND(fullName: "North Dakota"),
  OH(fullName: "Ohio"),
  OK(fullName: "Oklahoma"),
  OR(fullName: "Oregon"),
  PA(fullName: "Pennsylvania"),
  RI(fullName: "Rhode Island"),
  SC(fullName: "South Carolina"),
  SD(fullName: "South Dakota"),
  TN(fullName: "Tennessee"),
  TX(fullName: "Texas"),
  UT(fullName: "Utah"),
  VT(fullName: "Vermont"),
  VA(fullName: "Virginia"),
  WA(fullName: "Washington"),
  WV(fullName: "West Virginia"),
  WI(fullName: "Wisconsin"),
  WY(fullName: "Wyoming");

  const USState({
    required this.fullName,
  });

  final String fullName;
}
