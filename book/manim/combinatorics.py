from manim import *

class BallsBoxes1(Scene):
    def construct(self):
        where = [1, 0, 1, 1, 0]
        boxes = VGroup(*(
            [
                VGroup(
                    Square(stroke_color = BLACK),
                    Circle(
                        fill_color = BLACK,
                        fill_opacity = 1 if b else 0,
                        stroke_opacity = 0,
                        radius = 0.75,
                    ),
                )
                for b in where
            ] + list(map(
                lambda x: SVGMobject(x).scale(0.5),
                ['red-apple.svg', 'banana.svg', 'tangerine.svg', 'pear.svg', 'grapes.svg']
            ))
        ))
        boxes.arrange_in_grid(rows = 2)
        self.add(boxes)

class BallsBoxes2(Scene):
    def construct(self):
        boxes = VGroup(*(
            [
                VGroup(
                    Square(stroke_color = BLACK),
                    Circle(
                        fill_color = BLACK,
                        fill_opacity = 1 if b else 0,
                        stroke_opacity = 0,
                        radius = 0.75,
                    ),
                    Text(str(b), fill_opacity = 1 if b else 0, fill_color = WHITE),
                )
                for b in [
                    1, 0, 2, 3, 0,
                    2, 0, 3, 1, 0,
                ]
            ] + list(map(
                lambda x: SVGMobject(x).scale(0.5),
                ['red-apple.svg', 'banana.svg', 'tangerine.svg', 'pear.svg', 'grapes.svg']
            ))
        ))
        boxes.arrange_in_grid(rows = 3)
        self.add(boxes)

class BallsBoxes3(Scene):
    def construct(self):
        red_apple, banana, tangerine, pear, grapes = list(map(
            lambda x: SVGMobject(x).scale(0.5),
            ['red-apple.svg', 'banana.svg', 'tangerine.svg', 'pear.svg', 'grapes.svg']
        ))
        boxes = VGroup(*(
            [
                VGroup(
                    Square(stroke_color = BLACK).scale(0.75),
                    Circle(
                        fill_color = BLACK,
                        fill_opacity = 1 if b else 0,
                        stroke_opacity = 0,
                        radius = 0.5,
                    ),
                    MathTex(b, fill_opacity = 1 if b else 0, fill_color = WHITE),
                )
                for b in [2, 0, 3, 1, 0]
            ] + [red_apple, banana, tangerine, pear, grapes]
        ))
        boxes.arrange_in_grid(rows = 2)
        permutation = VGroup(*[
            pear.copy(), red_apple.copy(), tangerine.copy(),
            MathTex(1, fill_color = BLACK), MathTex(2, fill_color = BLACK), MathTex(3, fill_color = BLACK)
        ])
        permutation.arrange_in_grid(rows = 2)
        both = VGroup(boxes, permutation)
        both.arrange_in_grid(rows = 2, buff = 1)
        self.add(both)

class InclusionExclusion1(Scene):
    def construct(self):
        a = Circle(
            radius = 3,
            stroke_opacity = 0,
            fill_opacity = 0,
        ).move_to(1.5 * LEFT)
        b = Circle(
            radius = 3,
            stroke_opacity = 0,
            fill_opacity = 0,
        ).move_to(1.5 * RIGHT)
        anb = Intersection(a, b,
            stroke_color = BLACK,
            fill_opacity = 1,
            fill_color = PURPLE
        )
        awb = Difference(a, b,
            stroke_color = BLACK,
            fill_opacity = 1,
            fill_color   = ORANGE,
        )
        bwa = Difference(b, a,
            stroke_color = BLACK,
            fill_opacity = 1,
            fill_color   = BLUE,
        )
        [
            red_apple,
            banana,
            tangerine,
            pear,
            grapes,
            mushroom,
            carrot,
            bell_pepper,
            onion,
            avocado,
        ] = list(map(
            lambda x: SVGMobject(x).scale(0.5),
            [
                'red-apple.svg',
                'banana.svg',
                'tangerine.svg',
                'pear.svg',
                'grapes.svg',
                'mushroom.svg',
                'carrot.svg',
                'bell-pepper.svg',
                'onion.svg',
                'avocado.svg',
            ]
        ))
        red_apple.move_to(3.5 * LEFT)
        tangerine.move_to(red_apple.get_center() + 0.6 * RIGHT + 1.2 * UP)
        pear     .move_to(red_apple.get_center() + 1.5 * RIGHT + 2   * UP)
        banana   .move_to(red_apple.get_center() + 0.6 * RIGHT + 1.2 * DOWN)
        grapes   .move_to(red_apple.get_center() + 1.5 * RIGHT + 2   * DOWN)

        avocado    .move_to(0.8 * UP)
        bell_pepper.move_to(0.8 * DOWN)

        mushroom.move_to(3.5 * RIGHT)
        carrot  .move_to(mushroom.get_center() + 0.6 * LEFT + 1.2 * UP)
        onion   .move_to(mushroom.get_center() + 0.6 * LEFT + 1.2 * DOWN)

        awb_group = VGroup(awb, red_apple, tangerine, pear, banana, grapes)
        bwa_group = VGroup(bwa, mushroom, carrot, onion)
        anb_group = VGroup(anb, avocado, bell_pepper)
        self.add(
            awb_group,
            bwa_group,
            anb_group,
        )

class InclusionExclusion2(Scene):
    def construct(self):
        a = Circle(
            radius = 3,
            stroke_opacity = 0,
            fill_opacity = 0,
        ).move_to(1.5 * LEFT)
        b = Circle(
            radius = 3,
            stroke_opacity = 0,
            fill_opacity = 0,
        ).move_to(1.5 * RIGHT)

        anb = Intersection(a, b,
            stroke_color = BLACK,
            fill_opacity = 1,
            fill_color = PURPLE
        )
        awb = Difference(a, b,
            stroke_color = BLACK,
            fill_opacity = 1,
            fill_color   = ORANGE,
        )
        bwa = Difference(b, a,
            stroke_color = BLACK,
            fill_opacity = 1,
            fill_color   = BLUE,
        )

        anb2 = anb.copy()

        awb.move_to(awb.get_center() + 2 * LEFT)
        anb.move_to(anb.get_center() + 2 * LEFT)
        bwa.move_to(bwa.get_center() + 2 * RIGHT)
        anb2.move_to(anb2.get_center() + 2 * RIGHT)
        self.add(awb, anb, bwa, anb2)

class InclusionExclusion3(Scene):
    def construct(self):
        t = Triangle(radius = 1.2).rotate(180 * DEGREES)
        vs = t.get_vertices()
        a = Circle(
            radius = 2,
            stroke_color = BLACK,
            fill_opacity = 1,
            fill_color = ORANGE,
        ).move_to(vs[2])
        b = Circle(
            radius = 2,
            stroke_color = BLACK,
            fill_opacity = 1,
            fill_color = BLUE,
        ).move_to(vs[1])
        c = Circle(
            radius = 2,
            stroke_color = BLACK,
            fill_opacity = 1,
            fill_color = GREEN,
        ).move_to(vs[0])
        anb = Intersection(a, b,
            stroke_color = BLACK,
            fill_opacity = 1,
            fill_color = PURPLE,
        )
        anc = Intersection(a, c,
            stroke_color = BLACK,
            fill_opacity = 1,
            fill_color = YELLOW,
        )
        bnc = Intersection(b, c,
            stroke_color = BLACK,
            fill_opacity = 1,
            fill_color = TEAL,
        )
        anbnc = Intersection(a, b, c,
            stroke_color = BLACK,
            fill_opacity = 1,
            fill_color = GREY_BROWN,
        )
        self.add(a, b, c, anb, anc, bnc, anbnc)
