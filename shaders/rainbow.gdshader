shader_type canvas_item;

uniform float speed = 1.0; // Speed of the rainbow effect
uniform float blend_factor : hint_range(0.0, 1.0) = 0.2; // Blend factor for tinting

void fragment() {
    // Calculate the hue based on the fragment's position and elapsed time
    float hue = mod((FRAGCOORD.x + FRAGCOORD.y) * 0.01 + TIME * speed, 1.0);

    // Convert hue to RGB
    vec3 rainbow_color = vec3(0.0);
    float x = hue * 6.0;
    float c = 1.0;
    float m = 0.0;
    float X = c * (1.0 - abs(mod(x, 2.0) - 1.0));

    if (x < 1.0) {
        rainbow_color = vec3(c, X, m);
    } else if (x < 2.0) {
        rainbow_color = vec3(X, c, m);
    } else if (x < 3.0) {
        rainbow_color = vec3(m, c, X);
    } else if (x < 4.0) {
        rainbow_color = vec3(m, X, c);
    } else if (x < 5.0) {
        rainbow_color = vec3(X, m, c);
    } else {
        rainbow_color = vec3(c, m, X);
    }

    // Get the original color of the texture
    vec4 original_color = texture(TEXTURE, UV);

    // Blend the original color with the rainbow color using the adjustable blend factor
    vec3 final_color = mix(original_color.rgb, rainbow_color, blend_factor);

    // Set the final color
    COLOR = vec4(final_color, original_color.a);
}
