//http://wdnuon.blogspot.com/2010/05/implementing-ibooks-page-curling-using.html
shader_type spatial;
render_mode unshaded;

uniform sampler2D tex: hint_albedo;
uniform float width = 48;
uniform float height = 32;

void vertex() {
	float PI  = 3.14159265358979323846264;
	float Px = (VERTEX.x + width / 2.0) / width * 0.8;
	float Py = (-VERTEX.z + height / 2.0) / height;
	
	float t = 1.0 - (TIME - floor(TIME));
	float A = - 15.0 * t;
	float h = PI / 2.0 * t;
	float Rc = sqrt(Px * Px + pow(Py - A, 2));
	float d = Rc * sin(h);
	float alpha = asin(Px / Rc);
	float beta = alpha / sin(h);
	float x = d * sin(beta);
	VERTEX.x = x * width / 0.8 - width / 2.0;
	float y = Rc + A - d * (1.0 - cos(beta)) * sin(h);
	VERTEX.z = -(y * height - height/2.0);
	float z = d * (1.0 - cos(beta)) * cos(h);
	VERTEX.y = z*20.0;
}

void fragment() {
	ALBEDO = texture(tex, UV).rgb;
}