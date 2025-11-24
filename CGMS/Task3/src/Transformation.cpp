#include "Transformation.h"

namespace Transform
{
    Transform2D Scale2D(double sx, double sy)
    {
        // ToDo: Task 1 - Create and return a Transform2D (a 3x3)
        // matrix for scaling in 2D homogeneous coordinate system.
        // Update the return function as required.
        Transform2D scaleMatrix={
            {sx,0.0,0.0},
            {0.0,sy,0.0},
            {0.0,0.0,1.0}
        };
        return scaleMatrix;
    }

    Transform2D Rotate2D(double theta)
    {
        // ToDo: Task 1 - Create and return a Transform2D (a 3x3)
        // matrix for rotating in 2D homogeneous coordinate system.
        // Update the return function as required.
        // 
        // [N.B.] Theta should be in radians. You can use blaze::cos
        // or blaze::sin functions to calculate cosine and sine of
        // values.
        Transform2D rotateMatrix={
            {cos(theta),-sin(theta),0.0},
            {sin(theta),cos(theta),0.0},
            {0.0,0.0,1.0}
        };
        return rotateMatrix;
    }

    Transform2D Translate2D(double dx, double dy)
    {
        // ToDo: Task 1 - Create and return a Transform2D (a 3x3)
        // matrix for translating in 2D homogeneous coordinate 
        // system. Update the return function as required.
        Transform2D translateMatrix={
            {1.0,0.0,dx},
            {0.0,1.0,dy},
            {0.0,0.0,1.0}
        };
        return translateMatrix;
    }
}
