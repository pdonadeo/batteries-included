(* 
 * ExtChar - Additional character operations
 * Copyright (C) 1996 Xavier Leroy
 *               2008 David Teller
 * 
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version,
 * with the special exception on linking described in file LICENSE.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *)


module Char : sig

(** Character operations. *)

external code : char -> int = "%identity"
(** Return the ASCII code of the argument. *)

val is_whitespace : char -> bool
(** Determine if a character is a whitespace.
    Whitespace characters are defined as 
    [' '], ['\010'], ['\013'], ['\009'], ['\026']
    and ['\012']. *)

val of_digit : int -> char
(** Return the character representing a given digit.
    Raise [Invalid_argument "Char.of_digit"] if the
    argument is outside the range 0--9*)

val chr : int -> char
(** Return the character with the given ASCII code.
   Raise [Invalid_argument "Char.chr"] if the argument is
   outside the range 0--255. *)

val escaped : char -> string
(** Return a string representing the given character,
   with special characters escaped following the lexical conventions
   of Objective Caml. *)

val lowercase : char -> char
(** Convert the given character to its equivalent lowercase character. *)

val uppercase : char -> char
(** Convert the given character to its equivalent uppercase character. *)

type t = char
(** An alias for the type of characters. *)

val compare: t -> t -> int
(** The comparison function for characters, with the same specification as
    {!Pervasives.compare}.  Along with the type [t], this function [compare]
    allows the module [Char] to be passed as argument to the functors
    {!Set.Make} and {!Map.Make}. *)

val enum: unit -> char Enum.t
(** Produce the enumeration of all characters *)

val range: ?until:char -> char -> char Enum.t

val ( -- ): char -> char -> char Enum.t

(**/**)

external unsafe_chr : int -> char = "%identity"
external unsafe_int : char-> int  = "%identity"

end
