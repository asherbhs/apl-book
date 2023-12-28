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
