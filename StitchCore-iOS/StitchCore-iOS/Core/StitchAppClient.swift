import MongoSwift
import StitchCore

/**
 * The fundamental set of methods for communicating with a MongoDB Stitch application.
 * Contains methods for executing Stitch functions and retrieving clients for Stitch services,
 * and contains a StitchAuth object to manage the authentication state of the client. An
 * implementation can be instantiated using the `Stitch` utility class.
 */
public protocol StitchAppClient {

    // MARK: Authentication

    /**
     * The StitchAuth object representing the authentication state of this client.
     *
     * - important: Authentication state can be persisted beyond the lifetime of an application.
     *              A StitchAppClient retrieved from the `Stitch` singleton may or may not be
     *              authenticated when first initialized.
     */
    var auth: StitchAuth { get }

    // MARK: Services

    /**
     * Retrieves the service client associated with the Stitch service with the specified name and type.
     *
     * - parameters:
     *     - forFactory: An `AnyNamedServiceClientFactory` object which contains a `NamedServiceClientFactory`
     *                   class which will provide the client for this service.
     *     - withName: The name of the service as defined in the MongoDB Stitch application.
     * - returns: a service client whose type is determined by the `T` type parameter of the
     *            `AnyNamedServiceClientFactory` passed in the `forFactory` parameter.
     */
    func serviceClient<T>(forFactory factory: AnyNamedServiceClientFactory<T>, withName serviceName: String) -> T

    /**
     * Retrieves the service client associated with the service type specified in the argument.
     *
     * - parameters:
     *     - forFactory: An `AnyNamedServiceClientFactory` object which contains a `NamedServiceClientFactory`
     *                   class which will provide the client for this service.
     * - returns: a service client whose type is determined by the `T` type parameter of the
     *            `AnyNamedServiceClientFactory` passed in the `forFactory` parameter.
     */
    func serviceClient<T>(forFactory factory: AnyNamedServiceClientFactory<T>) -> T

    /**
     * Retrieves the service client associated with the service type specified in the argument.
     *
     * - parameters:
     *     - forFactory: An `AnyThrowingServiceClientFactory` object which contains a `ThrowingServiceClientFactory`
     *                    class which will provide the client for this service.
     * - returns: a service client whose type is determined by the `T` type parameter of the
     *            `AnyThrowingServiceClientFactory` passed in the `forFactory` parameter.
     */
    func serviceClient<T>(forFactory factory: AnyThrowingServiceClientFactory<T>) throws -> T

    // MARK: Functions

    // swiftlint:disable line_length
    /**
     * Calls the MongoDB Stitch function with the provided name and arguments.
     *
     * - parameters:
     *     - withName: The name of the Stitch function to be called.
     *     - withArgs: The `BSONArray` of arguments to be provided to the function.
     *     - completionHandler: The completion handler to call when the function call is complete.
     *                          This handler is executed on a non-main global `DispatchQueue`.
     *     - result: The result of the function call as `T`, or `nil` if the function call failed.
     *     - error: An error object that indicates why the function call failed, or `nil` if the function call was
     *              successful.
     *
     */
    func callFunction<T: Decodable>(withName name: String, withArgs args: [BsonValue], _ completionHandler: @escaping (_ result: T?, _ error: Error?) -> Void)

    /**
     * Calls the MongoDB Stitch function with the provided name and arguments, as well as with a specified timeout. Use
     * this for functions that may run longer than the client-wide default timeout (15 seconds by default).
     *
     * - parameters:
     *     - withName: The name of the Stitch function to be called.
     *     - withArgs: The `BSONArray` of arguments to be provided to the function.
     *     - withRequestTimeout: The number of seconds the client should wait for a response from the server before
     *                           failing with an error.
     *     - completionHandler: The completion handler to call when the function call is complete.
     *                          This handler is executed on a non-main global `DispatchQueue`.
     *     - error: An error object that indicates why the function call failed, or `nil` if the function call was
     *              successful.
     *
     */
    func callFunction(withName name: String, withArgs args: [BsonValue], _ completionHandler: @escaping (_ error: Error?) -> Void)

    // swiftlint:disable line_length
    /**
     * Calls the MongoDB Stitch function with the provided name and arguments.
     *
     * - parameters:
     *     - withName: The name of the Stitch function to be called.
     *     - withArgs: The `BSONArray` of arguments to be provided to the function.
     *     - completionHandler: The completion handler to call when the function call is complete.
     *                          This handler is executed on a non-main global `DispatchQueue`.
     *     - result: The result of the function call as `T`, or `nil` if the function call failed.
     *     - error: An error object that indicates why the function call failed, or `nil` if the function call was
     *              successful.
     *
     */
    func callFunction<T: Decodable>(withName name: String, withArgs args: [BsonValue], withRequestTimeout requestTimeout: TimeInterval, _ completionHandler: @escaping (_ result: T?, _ error: Error?) -> Void)

    /**
     * Calls the MongoDB Stitch function with the provided name and arguments, as well as with a specified timeout. Use
     * this for functions that may run longer than the client-wide default timeout (15 seconds by default).
     *
     * - parameters:
     *     - withName: The name of the Stitch function to be called.
     *     - withArgs: The `BSONArray` of arguments to be provided to the function.
     *     - withRequestTimeout: The number of seconds the client should wait for a response from the server before
     *                           failing with an error.
     *     - completionHandler: The completion handler to call when the function call is complete.
     *                          This handler is executed on a non-main global `DispatchQueue`.
     *     - error: An error object that indicates why the function call failed, or `nil` if the function call was
     *              successful.
     *
     */
    func callFunction(withName name: String, withArgs args: [BsonValue], withRequestTimeout requestTimeout: TimeInterval, _ completionHandler: @escaping (_ error: Error?) -> Void)
    // swiftlint:enable line_length
}
