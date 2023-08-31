use hyper::service::{make_service_fn, service_fn};
use hyper::{Body, Request, Response, Server};
use std::time::SystemTime;
use std::{convert::Infallible, net::SocketAddr};

async fn handle(_: Request<Body>) -> Result<Response<Body>, Infallible> {
    let time = SystemTime::now()
        .duration_since(SystemTime::UNIX_EPOCH)
        .expect("Opz");
    let body = format!(
        r#"{{
            "timestamp": "{}"
        }}"#,
        time.as_secs()
    );
    Ok(Response::new(body.into()))
}

#[tokio::main]
async fn main() {
    let addr = SocketAddr::from(([127, 0, 0, 1], 9888));

    let make_svc = make_service_fn(|_conn| async { Ok::<_, Infallible>(service_fn(handle)) });

    let server = Server::bind(&addr).serve(make_svc);

    if let Err(e) = server.await {
        eprintln!("server error: {}", e);
    }
}
