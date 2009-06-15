(* camlp5r *)
(***********************************************************************)
(*                                                                     *)
(*                             Camlp5                                  *)
(*                                                                     *)
(*                Daniel de Rauglaudre, INRIA Rocquencourt             *)
(*                                                                     *)
(*  Copyright 2007 Institut National de Recherche en Informatique et   *)
(*  Automatique.  Distributed only by permission.                      *)
(*                                                                     *)
(***********************************************************************)

(* $Id: stdpp.mli,v 1.13 2007/08/08 07:47:26 deraugla Exp $ *)

(** Standard definitions. *)

type location = 'abstract;

exception Exc_located of location and exn;
   (** [Exc_located loc e] is an encapsulation of the exception [e] with
       the input location [loc]. To be used in quotation expanders
       and in grammars to specify some input location for an error.
       Do not raise this exception directly: rather use the following
       function [raise_with_loc]. *)

value raise_with_loc : location -> exn -> 'a;
   (** [raise_with_loc loc e], if [e] is already the exception [Exc_located],
       re-raise it, else raise the exception [Exc_located loc e]. *)

value make_lined_loc : int -> int -> (int * int) -> location;
   (** [make_lined_loc line_nb bol_pos (bp, ep)] creates a location starting
       at line number [line_nb], where the position of the beginning of the
       line is [bol_pos] and between the positions [bp] (included) and [ep]
       excluded. The positions are in number of characters since the begin
       of the stream. *)

value first_pos : location -> int;
   (** [first_pos loc] returns the position of the begin of the location in
       number of characters since the beginning of the stream. *)
value last_pos : location -> int;
   (** [first_pos loc] returns the position of the first character not
       of the location in number of characters since the beginning of
       the stream. *)
value line_nb : location -> int;
   (** [line_nb loc] returns the line number of the location or [-1] if
       the location does not contain a line number (i.e. built the old
       way with [make_loc] below. *)
value bol_pos : location -> int;
   (** [line_nb loc] returns the position of the beginning of the line
       of the location in number of characters since the beginning of
       the stream, or [0] if the location does not contain a line number
       (i.e. built the old with with [make_loc] below. *)
value encl_loc : location -> location -> location;
   (** [encl_loc loc1 loc2] returns the location starting at the smallest
       start and ending at the greatest end of the locations [loc1] and
       [loc2]. In simple words, it is the location enclosing [loc1] and
       [loc2]. *)
value shift_loc : int -> location -> location;
   (** [shift_loc sh loc] returns the location [loc] shifted with [sh]
       characters. The line number is not recomputed. *)
value sub_loc : location -> int -> int -> location;
   (** [sub_loc loc sh len] is the location [loc] shifted with [sh] characters
       and with length [len]. The previous ending position of the location
       is lost. *)
value after_loc : location -> int -> int -> location;
   (** [after_loc loc sh len] is the location just after loc (starting at
       the end position of [loc]) shifted with [sh] characters and of length
       [len]. *)

value loc_name : ref string;
   (** Name of the location variable used in grammars and in the predefined
       quotations for OCaml syntax trees. Default: [loc] *)

value dummy_loc : location;

type value_or_anti 'a =
  [ VaAnt of string
  | VaVal of 'a ]
;
   (* For internal use: this is a type for enclosing values which may be
      "antiquoted": in the syntax tree (see module [MLast]), some constructors
      contain such kind of types, allowing to have a syntax tree also usable
      in syntax tree quotations exanders.
        E.g. for the "rec" flac in the "let" binding:
      - <:str_item< let x = y in z >>: the "rec" flag is [VaVal False]
      - <:str_item< let rec x = y in z >>: it is [VaVal True]
      - <:str_item< let $a_flag:rf$ x = y in z >>: it is [VaAnt "rf"].
        The same syntax tree can therefore be used for normal parsing
      (outside quotations) and quotation parsing (inside quotations). This
      way, the same parser can be used for both, allowing the possible
      parsers extensions, or specific syntaxes, to be used in quotations
      (see quotation expander "q_ast". *)

(* for compatibility with other versions using locations *)

value line_of_loc : string -> location -> (string * int * int * int);
   (** [line_of_loc fname loc] reads the file [fname] up to the
       location [loc] and returns the real input file, the line number
       and the characters location in the line; the real input file
       can be different from [fname] because of possibility of line
       directives typically generated by /lib/cpp. *)
value make_loc : (int * int) -> location;
   (** [make_loc (bp, ep)] creates a location between the positions bp
       (included) and ep (excluded), each of them being the number of
       characters since the beginning of the stream. The location created
       does not contain the line number. *)
