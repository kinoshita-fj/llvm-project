//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// UNSUPPORTED: c++03

// <unordered_map>

// template <class Key, class T, class Hash = hash<Key>, class Pred = equal_to<Key>,
//           class Alloc = allocator<pair<const Key, T>>>
// class unordered_map

// template <class... Args>
//     pair<iterator, bool> emplace(Args&&... args);

#include <unordered_map>
#include <cassert>

#include "test_macros.h"
#include "../../../Emplaceable.h"
#include "min_allocator.h"

int main(int, char**) {
  {
    typedef std::unordered_map<int, Emplaceable> C;
    typedef std::pair<C::iterator, bool> R;
    C c;
    R r = c.emplace(std::piecewise_construct, std::forward_as_tuple(3), std::forward_as_tuple());
    assert(r.second);
    assert(c.size() == 1);
    assert(r.first->first == 3);
    assert(r.first->second == Emplaceable());

    r = c.emplace(std::pair<const int, Emplaceable>(4, Emplaceable(5, 6)));
    assert(r.second);
    assert(c.size() == 2);
    assert(r.first->first == 4);
    assert(r.first->second == Emplaceable(5, 6));

    r = c.emplace(std::piecewise_construct, std::forward_as_tuple(5), std::forward_as_tuple(6, 7));
    assert(r.second);
    assert(c.size() == 3);
    assert(r.first->first == 5);
    assert(r.first->second == Emplaceable(6, 7));
  }
  {
    typedef std::unordered_map<int,
                               Emplaceable,
                               std::hash<int>,
                               std::equal_to<int>,
                               min_allocator<std::pair<const int, Emplaceable>>>
        C;
    typedef std::pair<C::iterator, bool> R;
    C c;
    R r = c.emplace(std::piecewise_construct, std::forward_as_tuple(3), std::forward_as_tuple());
    assert(r.second);
    assert(c.size() == 1);
    assert(r.first->first == 3);
    assert(r.first->second == Emplaceable());

    r = c.emplace(std::pair<const int, Emplaceable>(4, Emplaceable(5, 6)));
    assert(r.second);
    assert(c.size() == 2);
    assert(r.first->first == 4);
    assert(r.first->second == Emplaceable(5, 6));

    r = c.emplace(std::piecewise_construct, std::forward_as_tuple(5), std::forward_as_tuple(6, 7));
    assert(r.second);
    assert(c.size() == 3);
    assert(r.first->first == 5);
    assert(r.first->second == Emplaceable(6, 7));
  }

  return 0;
}
