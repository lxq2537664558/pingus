//  $Id: mover.hxx,v 1.1 2003/02/12 22:43:38 torangan Exp $
//
//  Pingus - A free Lemmings clone
//  Copyright (C) 1999 Ingo Ruhnke <grumbel@gmx.de>
//
//  This program is free software; you can redistribute it and/or
//  modify it under the terms of the GNU General Public License
//  as published by the Free Software Foundation; either version 2
//  of the License, or (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program; if not, write to the Free Software
//  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

#ifndef HEADER_PINGUS_MOVER_HXX
#define HEADER_PINGUS_MOVER_HXX

#include "vector.hxx"

class Collider;
class World;

class Mover
{
  public:
    /** Constructor of abstract class */
    Mover(World* const world_arg, const Vector& pos_arg);

    /** Destructor of abstract class */
    virtual ~Mover() = 0;

    /** Updates the position of the object taking into account collisions */
    virtual void update(const Vector& move, const Collider& collider) = 0;

    /** Get the resulting position vector */
    Vector get_pos() const;

    /** Get the move vector remaining after a collision */
    Vector remaining() const;

    /** Get whether object stopped moving because it collided with something */
    bool collided() const;

  protected:
    /** World in which the object should move */
    World* const world;
    
    /** Position of the object to move */
    Vector pos;

    /** Move vector remaining after a collision */
    Vector remaining_move;

    /** Flag to denote whether object has had a collision */
    bool collision;
};

#endif

/* EOF */
