shader_type canvas_item;

uniform float time : hint_range(0, 10); // You can animate this over time
uniform float speed = 1.0; // Speed of the rainbow effect

void fragment() {
    // Calculate position-based hue
    float hue = mod((FRAGCOORD.x + FRAGCOORD.y) * 0.01 + time * speed, 1.0);
    
    // Convert hue to RGB
    vec3 color = vec3(0.0);
    float x = hue * 6.0;
    float c = 1.0;
    float m = 0.0;
    float X = c * (1.0 - abs(mod(x, 2.0) - 1.0));
    
    if (x < 1.0) {
        color = vec3(c, X, m);
    } else if (x < 2.0) {
        color = vec3(X, c, m);
    } else if (x < 3.0) {
        color = vec3(m, c, X);
    } else if (x < 4.0) {
        color = vec3(m, X, c);
    } else if (x < 5.0) {
        color = vec3(X, m, c);
    } else {
        color = vec3(c, m, X);
    }
    
    COLOR = vec4(color, 1.0);
}
