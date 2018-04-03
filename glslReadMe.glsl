
1、顶点着色器内容描述
    /*在你的场景中，每个顶点都需要调用的程序，称为“顶点着色器”。假如你在渲染一个简单的场景：一个长方形，每个角只有一个顶点。于是vertex shader 会被调用四次。它负责执行：诸如灯光、几何变换等等的计算。得出最终的顶点位置后，为下面的片段着色器提供必须的数据。*/

    attribute vec4 Position; /* 1.“attribute”声明了这个shader会接受一个传入变量，这个变量名为“Position”。在后面的代码中，你会用它来传入顶点的位置数据。这个变量的类型是“vec4”,表示这是一个由4部分组成的矢量。attribute 修饰符只可用于顶点着色。*/
    attribute vec4 SourceColor; /* 2  这里是传入顶点的颜色变量*/
    uniform mat4 Projection; /* uniforms保存由应用程序传递给着色器的只读常量数据*/
    uniform mat4 Modelview;  /* uniforms保存由应用程序传递给着色器的只读常量数据*/
    varying vec4 DestinationColor; /*3 这个变量没有“attribute”的关键字。表明它是一个传出变量，它就是会传入片段着色器的参数。“varying”关键字表示，依据顶点的颜色，平滑计算出顶点之间每个像素的颜色。顶点着色器中声明的 varying 变量都应在片元着色器中重新声明同名同类型的 varying 变量*/

    void main(void) { /* 4 每个shader都从main开始– 跟C一样嘛。*/
        DestinationColor = SourceColor; /* 5 设置目标颜色 = 传入变量：SourceColor*/
        gl_Position = Projection * Modelview * Position; /*gl_Position 是一个内建的传出变量。这是一个在 vertex shader中必须设置的变量。这里我们对传出变量进行逻辑运算*/
    }

2、片段着色器内容描述
    //在你的场景中，大概每个像素都会调用的程序，称为“片段着色器”。在一个简单的场景，也是刚刚说到的长方形。这个长方形所覆盖到的每一个像素，都会调用一次fragment shader。片段着色器的责任是计算灯光，以及更重要的是计算出每个像素的最终颜色。

    varying lowp vec4 DestinationColor; //这是从vertex shader中传入的变量，这里和vertex shader定义的一致。而额外加了一个关键字：lowp。在fragment shader中，必须给出一个计算的精度。出于性能考虑，总使用最低精度是一个好习惯。这里就是设置成最低的精度。如果你需要，也可以设置成medp或者highp.

    varying lowp vec2 TexCoordOut;
    uniform sampler2D Texture;

    void main(void) {
        gl_FragColor = DestinationColor * texture2D(Texture, TexCoordOut); //正如你在vertex shader中必须设置gl_Position, 在fragment shader中必须设置gl_FragColor. 这里也是直接从 vertex shader中取值，先不做任何改变
    }


//attribute:只能在Vertexshader中使用;
//Unifrom:在Vertex和Fragment中共享使用,且不能被修改;
//Varying:从Vertex传递数据到Fragment中使用;

/*
 OpenGL ES 编程语言数据类型
 变量类                           Types                          Description
 Scalars                      float, int, bool              标量数据类型浮点数、整形数、布尔值
 Floating-point Vectors       float, vec2, vec3, vec4       浮点型矢量，1、2、3、4 维
 Integer vector               int, ivec2, ivec3, ivec4      整形矢量，1、2、3、4 维
 Boolean vector               int, ivec2, ivec3, ivec4      布尔矢量，1、2、3、4 维
 Matrices                     mat2, mat3, mat4              浮点类型矩阵 2×2,3×3,4×4
 */



//#ifdef GL_FRAGMENT_PRECISION_HIGH  宏判断当前设备是否支持高精度
//        precision highp float;
//#else
//        precision mediump float;
//#endif

//precision highp float;  在顶部设置默认精度
//precision mediump int;

/*
    平面贴图texture2D 函数如下。
    vec4 texture2D(sampler2D sampler, vec2 coord[,float bias])
        sampler     一个指定贴图格式绑定到贴图单元的采样器
        coord       使用去获取贴图匹配的 2D 贴图坐标
        bias        可选的参数，为获取贴图的多级纹理偏置。允许着色器解释计算 LOD 值的偏置，被用于多级纹理选择。
 
    立体贴图textureCube 函数如下：
    vec4 textureCube(samplerCube sampler, vec3 coord[,float bias])
        sampler     绑定到贴图单元的采样器，指定获取的贴图
        coord       被用于立方体贴图的 3D 贴图坐标
        bias        用于获取贴图提供多级纹理偏置的可选参数，允许着色器解释计算 LOD 值的偏置，被用于多级纹理选择。
 
*/

/*
    3D贴图函数
    vec4 texture3D(sampler3D sampler, vec3 coord[, float bias])
        sampler     绑定贴图单元，指定贴图获取的采样器
        coord       使用去获取贴图匹配的 3D 贴图坐标
        bias        用于获取贴图提供多级纹理偏置的可选参数，允许着色器解释计算 LOD 值的偏置， 被用于多级纹理选择。

 */
