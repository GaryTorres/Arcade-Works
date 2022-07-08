
ROMOffset  SET  $100000    ; 写入位置偏移    // 100000 = ROM  |  0 = 模拟器内存

; ==================================================

; ROM 空白区域

    ORG  $380000-ROMOffset

; ==================================================

    movem.l  D2/A3, -(A7)

        jsr  $10A736    ; 取可用敌方结构体 ID
        move.l  D0, D2    ; 转存

        pea  0.w    ; push 角色色表指针列表索引 ID
        pea  1.w    ; push 面向
        pea  0.w    ; push 敌方出现坐标 Z
        pea  $E6.w    ; push 敌方出现坐标 Y
        pea  $230.w    ; push 敌方出现坐标 X
        pea  $22CA02    ; push 敌方角色指针    // 貂蝉
        move.l  D2, -(A7)    ; push 敌方结构体 ID
        jsr  $10AEB6    ; 处理敌方 OBJ 结构体

        move.l  D2, -(A7)    ; push 敌方结构体 ID
        jsr  $10E732    ; 以敌方 ID 取结构体基址
        movea.l  D0, A3    ; 转存

        move.l  A3, -(A7)    ; push 敌方基址
        jsr  $10AABA    ; 关联血条结构体

        lea  ($24, A7), A7

        pea  $1.w
        pea  $2.w
        move.l  A3, -(A7)    ; push 敌方基址
        jsr  $10E248    ; 取动作指针至 D0
        move.l  D0, -(A7)
        move.l  A3, -(A7)    ; push 敌方基址
        jsr  $10E3CE    ; 调用动作
        lea  ($14, A7), A7

        pea  $2.w
        pea  $25AD64    ; 第一关孙姬
        move.l  A3, -(A7)    ; push 敌方基址
        jsr  $143BE2    ; 设置敌将撞物
        lea  ($0c, A7), A7

    movem.l  (A7)+, D2/A3
    rts
