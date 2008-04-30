(* 
 * ExtInt - Extended integers
 * Copyright (C) 2007 Bluestorm <bluestorm dot dylc on-the-server gmail dot com>
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

open Number

let enum () =
  let current_value   = ref min_int in
  let already_through = ref false   in
  let f  () =
    if  !current_value = max_int then
      if !already_through then raise Enum.No_more_elements
      else ( already_through := true; max_int )
    else Ref.pre_incr current_value
  in Enum.from f

module BaseInt = struct
  
  type t = int
  
  let zero, one = 0, 1

  let neg = (~-)
  let succ, pred, abs = succ, pred, abs

  let add, sub, mul, div = (+), (-), ( * ), (/)

  let modulo a b = a mod b
  let pow = generic_pow ~zero ~one ~div_two:(fun n -> n / 2) ~mod_two:(fun n -> n mod 2) ~mul

  let min_num, max_num = min_int, max_int
  let compare = (-)

  let of_int n = n
  let to_int n = n

  let of_string = int_of_string
  let to_string = string_of_int

  let enum = enum
end


module BaseSafeInt = struct
  (**Integers with checked overflows*)
  type t = int

  module Operators = struct
    (**
       Open this module and [SafeInt] to replace traditional integer operators with
       their safe counterparts
    *)

    (*Here, we assume that, in case of overflow the result will be different when computing
      in 31 bits (resp 63 bits) and in 32 bits (resp 64 bits). Need to check that trick.*)
    let ( * ) a b =
      let c  = Pervasives.( * ) a b                                    in
      let c' = Nativeint.mul (Nativeint.of_int a) (Nativeint.of_int b) in
	if Nativeint.of_int c = c' then c
	else raise Overflow

    let ( + ) a b =
    let c = Pervasives.( + ) a b in
      if a < 0 && b < 0 && c >= 0 || a > 0 && b > 0 && c <= 0	then raise Overflow
      else c

    let ( - ) a b =
    let c = Pervasives.( - ) a b in
      if a < 0 && b > 0 && c >= 0 || a > 0 && b < 0 && c <= 0	then raise Overflow
      else c
  end
  
  let zero, one = 0, 1

  let neg x = 
    if x <> min_int then ~- x
    else raise Overflow

  let succ x =
    if x <> max_int then succ x
    else raise Overflow

  let pred x =
    if x <> min_int then pred x
    else raise Overflow
    
  let abs x =
    if x <> min_int then abs x
    else raise Overflow

  let add = Operators.( + )

  let sub = Operators.( - )

  let mul = Operators.( * )

  let div = ( / )

  let modulo a b = a mod b

  let pow = BaseInt.pow

  let min_num, max_num = min_int, max_int
  let compare = (-)

  let of_int n = n
  let to_int n = n

  let of_string = int_of_string
  let to_string = string_of_int

  let enum = enum

end

module Int     = Numeric(BaseInt)
module SafeInt = Numeric(BaseSafeInt)

