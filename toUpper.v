`timescale 1ns / 1ps
module toUpper (in, out);
  input  [7:0] in; // instead of listing all 8 bits separately, used a vector instead for easier handling (in[0] to in[7]) as recommended in class
  output [7:0] out; // using vector for output as well

  wire a7n, a6n, a5n, a4n, a3n, a2n, a1n, a0n; // complements of input bits
  not #5 N7(a7n, in[7]);
  not #5 N6(a6n, in[6]);
  not #5 N5(a5n, in[5]);
  not #5 N4(a4n, in[4]);
  not #5 N3(a3n, in[3]);
  not #5 N2(a2n, in[2]);
  not #5 N1(a1n, in[1]);
  not #5 N0(a0n, in[0]);

  wire p1, p2, p3, p4, p5; // product terms from k-map
  // p1 = A7' A6' A5
  and #10 P1(p1, a7n, a6n, in[5]);
  // p2 = A7' A5 A4' A3' A2' A1' A0'
  and #10 P2(p2, a7n, in[5], a4n, a3n, a2n, a1n, a0n);
  // p3 = A7' A6 A5 A4 A3 A2
  and #10 P3(p3, a7n, in[6], in[5], in[4], in[3], in[2]);
  // p4 = A7' A6 A5 A4 A3 A2' A1 A0
  and #10 P4(p4, a7n, in[6], in[5], in[4], in[3], a2n, in[1], in[0]);
  // p5 = A7 A5
  and #10 P5(p5, in[7], in[5]);

  // Sum of products: p1 + p2 + p3 + p4 + p5
  or  #10 S_OR(out[5], p1, p2, p3, p4, p5);

  // pass other bits straight through
  buf #4 B7 (out[7], in[7]);
  buf #4 B6 (out[6], in[6]);
  buf #4 B4 (out[4], in[4]);
  buf #4 B3 (out[3], in[3]);
  buf #4 B2 (out[2], in[2]);
  buf #4 B1 (out[1], in[1]);
  buf #4 B0 (out[0], in[0]);

endmodule
